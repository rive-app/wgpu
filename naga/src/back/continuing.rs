/*!
Finding the temporaries a loop's `continuing` block needs from its body.

Naga IR's [`Loop`] statement runs its `continuing` block after its `body`, but
the textual backends have no equivalent construct, so they write `continuing`
at the *top* of a `while` loop, skipped on the first iteration. Temporaries the
body declares are then out of reach of `continuing`, so each backend declares
the ones `continuing` needs ahead of the loop and has the body assign to them.

[`Loop`]: crate::Statement::Loop
*/

use alloc::vec::Vec;

use crate::{
    arena::{Arena, Handle, HandleSet},
    compact::ModuleTracer,
    proc::TypeResolution,
};

/// The temporaries `body` defines that the code written for `continuing` and
/// `break_if` refers to, in increasing handle order. `bakes` says which
/// expressions the backend gives a temporary at all.
///
/// Skipping the rest is deliberate: `continuing` re-evaluates those in place,
/// and that is sound, because every expression whose value depends on *when*
/// it is evaluated already gets a temporary. Loads, samples and derivatives
/// have a `bake_ref_count` of one, so any use at all bakes them, and statement
/// results have no inline form. What's left to re-evaluate is arithmetic and
/// address computation.
pub(super) fn continuing_dependencies(
    module: &crate::Module,
    function: &crate::Function,
    info: &crate::valid::FunctionInfo,
    body: &crate::Block,
    continuing: &crate::Block,
    break_if: Option<Handle<crate::Expression>>,
    bakes: impl Fn(Handle<crate::Expression>) -> bool,
) -> Vec<Handle<crate::Expression>> {
    let mut candidates = HandleSet::for_arena(&function.expressions);
    // A handle such as a texture cannot be declared ahead and assigned later,
    // so `continuing` re-evaluates it, reading its operands' temporaries.
    for handle in definitions(&function.expressions, body).iter() {
        if bakes(handle) && fits_in_temporary(module, info, handle) {
            candidates.insert(handle);
        }
    }
    if candidates.is_empty() {
        return Vec::new();
    }
    let used = expressions_used(module, function, continuing, break_if, &candidates);
    candidates
        .iter()
        .filter(|&handle| used.contains(handle))
        .collect()
}

/// Return the expressions that `block` itself computes values for, in
/// increasing handle order.
fn definitions(
    expressions: &Arena<crate::Expression>,
    block: &crate::Block,
) -> HandleSet<crate::Expression> {
    use crate::Statement as St;

    let mut defined = HandleSet::for_arena(expressions);
    for statement in block.iter() {
        match *statement {
            St::Emit(ref range) => defined.insert_iter(range.clone()),
            St::Atomic {
                result: Some(result),
                ..
            }
            | St::Call {
                result: Some(result),
                ..
            }
            | St::RayQuery {
                fun: crate::RayQueryFunction::Proceed { result },
                ..
            }
            | St::WorkGroupUniformLoad { result, .. }
            | St::SubgroupBallot { result, .. }
            | St::SubgroupGather { result, .. }
            | St::SubgroupCollectiveOperation { result, .. } => {
                defined.insert(result);
            }

            St::Atomic { result: None, .. }
            | St::Call { result: None, .. }
            | St::RayQuery {
                fun:
                    crate::RayQueryFunction::Initialize { .. }
                    | crate::RayQueryFunction::GenerateIntersection { .. }
                    | crate::RayQueryFunction::ConfirmIntersection
                    | crate::RayQueryFunction::Terminate,
                ..
            }
            | St::Block(_)
            | St::If { .. }
            | St::Switch { .. }
            | St::Loop { .. }
            | St::Break
            | St::Continue
            | St::Return { .. }
            | St::Kill
            | St::ControlBarrier(_)
            | St::MemoryBarrier(_)
            | St::Store { .. }
            | St::ImageStore { .. }
            | St::ImageAtomic { .. }
            | St::RayPipelineFunction(_)
            | St::CooperativeStore { .. } => {}
        }
    }
    defined
}

/// Return the expressions of `function` that the code generated for `block`
/// and `extra_roots` will refer to, directly or indirectly.
///
/// This is wider than what `block` needs the values of, because we do no dead
/// code elimination: `Writer::put_block` writes out a definition for every
/// expression it bakes, whether or not anything reads it, and that definition
/// refers to the expression's operands. Hence
/// [`trace_block_including_emits`] rather than [`trace_block`]. Miss those and
/// a dead definition would leave its operands un-hoisted, and `continuing`
/// would re-evaluate them in place - or, for a statement result, reach the
/// `unreachable!` in `Writer::put_expression`, which has no inline form to
/// fall back on.
///
/// The search does not continue past an expression in `stop_at`: such an
/// expression is marked if something refers to it, but the search does not
/// follow it to its operands. Anything reachable only through it is therefore
/// left out.
///
/// [`trace_block_including_emits`]: crate::compact::functions::FunctionTracer::trace_block_including_emits
/// [`trace_block`]: crate::compact::functions::FunctionTracer::trace_block
fn expressions_used(
    module: &crate::Module,
    function: &crate::Function,
    block: &crate::Block,
    extra_roots: impl IntoIterator<Item = Handle<crate::Expression>>,
    stop_at: &HandleSet<crate::Expression>,
) -> HandleSet<crate::Expression> {
    let mut module_tracer = ModuleTracer::new(module);

    let mut function_tracer = module_tracer.as_function(function);
    function_tracer.trace_block_including_emits(block);
    function_tracer.expressions_used.insert_iter(extra_roots);

    let mut expression_tracer = function_tracer.as_expression();
    for (handle, expression) in function.expressions.iter().rev() {
        if expression_tracer.expressions_used.contains(handle) && !stop_at.contains(handle) {
            expression_tracer.trace_expression(expression);
        }
    }

    function_tracer.expressions_used
}

/// Whether `expression` is the result of a statement.
///
/// There is no way to write these inline, so the statement that produces one
/// always stores it in a temporary, whether or not anything asked for one.
pub(super) const fn is_statement_result(expression: &crate::Expression) -> bool {
    use crate::Expression as Ex;
    match *expression {
        Ex::CallResult(_)
        | Ex::AtomicResult { .. }
        | Ex::WorkGroupUniformLoadResult { .. }
        | Ex::SubgroupBallotResult
        | Ex::SubgroupOperationResult { .. }
        | Ex::RayQueryProceedResult => true,

        Ex::Literal(_)
        | Ex::Constant(_)
        | Ex::Override(_)
        | Ex::ZeroValue(_)
        | Ex::Compose { .. }
        | Ex::Access { .. }
        | Ex::AccessIndex { .. }
        | Ex::Splat { .. }
        | Ex::Swizzle { .. }
        | Ex::FunctionArgument(_)
        | Ex::GlobalVariable(_)
        | Ex::LocalVariable(_)
        | Ex::Load { .. }
        | Ex::ImageSample { .. }
        | Ex::ImageLoad { .. }
        | Ex::ImageQuery { .. }
        | Ex::Unary { .. }
        | Ex::Binary { .. }
        | Ex::Select { .. }
        | Ex::Derivative { .. }
        | Ex::Relational { .. }
        | Ex::Math { .. }
        | Ex::As { .. }
        | Ex::ArrayLength(_)
        | Ex::RayQueryVertexPositions { .. }
        | Ex::RayQueryGetIntersection { .. }
        | Ex::CooperativeLoad { .. }
        | Ex::CooperativeMultiplyAdd { .. } => false,
    }
}

/// Whether a value of `handle`'s type can be held in a default-initialized
/// local temporary.
fn fits_in_temporary(
    module: &crate::Module,
    info: &crate::valid::FunctionInfo,
    handle: Handle<crate::Expression>,
) -> bool {
    use crate::TypeInner as Ti;
    match info[handle].ty {
        TypeResolution::Handle(ty) => matches!(
            module.types[ty].inner,
            Ti::Scalar(_)
                | Ti::Vector { .. }
                | Ti::Matrix { .. }
                | Ti::Array {
                    size: crate::ArraySize::Constant(_),
                    ..
                }
                | Ti::Struct { .. }
                | Ti::CooperativeMatrix { .. }
        ),
        TypeResolution::Value(
            Ti::Scalar(_) | Ti::Vector { .. } | Ti::Matrix { .. } | Ti::CooperativeMatrix { .. },
        ) => true,
        TypeResolution::Value(_) => false,
    }
}
