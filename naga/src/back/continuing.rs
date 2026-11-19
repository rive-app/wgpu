/*!
Finding the temporaries a loop's `continuing` block needs from its body, and
the loops a `for` statement can express.

Naga IR's [`Loop`] statement runs its `continuing` block after its `body`, but
the textual backends have no equivalent construct, so they write `continuing`
at the *top* of a `while` loop, skipped on the first iteration. Temporaries the
body declares are then out of reach of `continuing`, so each backend declares
the ones `continuing` needs ahead of the loop and has the body assign to them.

[`counted`] finds the loops a backend can write as a `for` loop instead, with
`continuing` as its step. Those need no gate, but the step still reads the
body's temporaries, so they are declared ahead all the same.

[`Loop`]: crate::Statement::Loop
*/

#[cfg(any(glsl_out, hlsl_out, msl_out))]
use alloc::vec::Vec;

use crate::arena::{Arena, Handle, HandleSet};
#[cfg(any(glsl_out, hlsl_out, msl_out))]
use crate::{compact::ModuleTracer, proc::TypeResolution};

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
#[cfg(any(glsl_out, hlsl_out, msl_out))]
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

/// A counted loop, as most of WGSL's `for` loops are: its body opens by
/// testing a local variable against a constant, and its `continuing` block is
/// one store to that variable.
///
/// Metal's compiler makes far faster code of one written as a `for` loop than
/// of one behind a first pass gate, and ANGLE guards few of them. Other bounds
/// stay gated: Metal ran slower with a `for` loop bounded by an argument.
#[cfg(any(glsl_out, msl_out, wgsl_out))]
pub(super) struct Counted {
    /// How many leading statements of the body the header replaces.
    pub skip: usize,
    pub condition: Handle<crate::Expression>,
    /// The counter, and the value the step stores to it.
    pub step: (Handle<crate::Expression>, Handle<crate::Expression>),
    /// Whether the step reads a value the body computes, which a header only
    /// can once that value is declared ahead of the loop.
    #[cfg(wgsl_out)]
    pub reads_body: bool,
}

/// Whether the loop is [`Counted`]. `bakes` says which expressions the backend
/// gives a temporary.
///
/// The header evaluates in place what the statements it replaces would have
/// held in temporaries, so only the test may read those, and only loads among
/// them may be baked: a load reads the same value there as at the top of the
/// body, unless it reads an atomic, which another invocation may store to
/// between two reads.
#[cfg(any(glsl_out, msl_out, wgsl_out))]
pub(super) fn counted(
    module: &crate::Module,
    function: &crate::Function,
    info: &crate::valid::FunctionInfo,
    body: &crate::Block,
    continuing: &crate::Block,
    break_if: Option<Handle<crate::Expression>>,
    bakes: impl Fn(Handle<crate::Expression>) -> bool,
) -> Option<Counted> {
    use crate::{BinaryOperator as Bo, Expression as Ex, Literal as Li, Statement as St};

    if break_if.is_some() {
        return None;
    }
    let expressions = &function.expressions;
    let is_emit = |statement: &St| matches!(*statement, St::Emit(_));
    let skip = body
        .iter()
        .take_while(|&statement| is_emit(statement))
        .count();
    let condition = match *body.get(skip)? {
        St::If {
            condition,
            ref accept,
            ref reject,
        } if accept.is_empty() && matches!(reject[..], [St::Break]) => condition,
        _ => return None,
    };
    let skip = skip + 1;
    let Ex::Binary { op, left, right } = expressions[condition] else {
        return None;
    };
    let Ex::Load { pointer: counter } = expressions[left] else {
        return None;
    };
    let (&St::Store { pointer, value }, emits) = continuing.split_last()? else {
        return None;
    };
    let bound = match expressions[right] {
        Ex::Literal(literal) => literal,
        Ex::Constant(constant) => {
            match module.global_expressions[module.constants[constant].init] {
                Ex::Literal(literal) => literal,
                _ => return None,
            }
        }
        _ => return None,
    };
    // ANGLE takes a loop whose test cannot fail for one that ends, and Metal
    // drops a loop that never does along with the code around it.
    let endless = matches!(
        (op, bound),
        (
            Bo::LessEqual,
            Li::I32(i32::MAX) | Li::U32(u32::MAX) | Li::I64(i64::MAX) | Li::U64(u64::MAX)
        ) | (
            Bo::GreaterEqual,
            Li::I32(i32::MIN) | Li::U32(0) | Li::I64(i64::MIN) | Li::U64(0)
        )
    );
    if endless
        || pointer != counter
        || !matches!(expressions[counter], Ex::LocalVariable(_))
        || !emits.iter().all(is_emit)
    {
        return None;
    }

    // Other expressions may come with statements of their own where they are emitted.
    let in_place = |handle| match expressions[handle] {
        Ex::Load { pointer } => {
            let types = &module.types;
            !info[pointer].ty.inner_with(types).is_atomic_pointer(types)
        }
        Ex::Unary { .. } | Ex::Binary { .. } | Ex::Math { .. } | Ex::As { .. } => !bakes(handle),
        _ => false,
    };
    let only_tested = |handle: Handle<crate::Expression>| {
        (handle == left || handle == condition) && info[handle].ref_count == 1
    };
    let tested = definitions(expressions, &body[..skip]);
    let stepped = definitions(expressions, continuing);
    #[cfg(wgsl_out)]
    let reads_body = {
        let computed = definitions(expressions, body);
        let operands = |handle: Handle<Ex>| match expressions[handle] {
            Ex::Load { pointer } => [Some(pointer), None, None, None],
            Ex::Unary { expr, .. } | Ex::As { expr, .. } => [Some(expr), None, None, None],
            Ex::Binary { left, right, .. } => [Some(left), Some(right), None, None],
            Ex::Math {
                arg,
                arg1,
                arg2,
                arg3,
                ..
            } => [Some(arg), arg1, arg2, arg3],
            _ => [None; 4],
        };
        computed.contains(value)
            || stepped
                .iter()
                .flat_map(operands)
                .flatten()
                .any(|operand| computed.contains(operand))
    };
    (tested
        .iter()
        .all(|handle| only_tested(handle) && in_place(handle))
        && stepped.iter().all(in_place))
    .then_some(Counted {
        skip,
        condition,
        step: (pointer, value),
        #[cfg(wgsl_out)]
        reads_body,
    })
}

/// Return the expressions that `block` itself computes values for, in
/// increasing handle order.
fn definitions(
    expressions: &Arena<crate::Expression>,
    block: &[crate::Statement],
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
#[cfg(any(glsl_out, hlsl_out, msl_out))]
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
#[cfg(any(glsl_out, hlsl_out, msl_out))]
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
#[cfg(any(glsl_out, hlsl_out, msl_out))]
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
