//! The values Adreno's Vulkan compiler reads again from their variable where
//! they are used rather than where they were loaded, after any later write.

use crate::{Expression, Function, Handle, Module, TypeInner};

/// Whether `load` reads a whole struct or array from a function or private
/// variable that `function` may write after it, which Adreno then reads anew.
pub(crate) fn reread_after_write(
    module: &Module,
    function: &Function,
    info: &crate::valid::FunctionInfo,
    load: Handle<Expression>,
) -> bool {
    let Expression::Load { pointer } = function.expressions[load] else {
        return false;
    };
    let from_variable = matches!(
        *info[pointer].ty.inner_with(&module.types),
        TypeInner::Pointer {
            space: crate::AddressSpace::Function | crate::AddressSpace::Private,
            ..
        }
    );
    from_variable
        && matches!(
            *info[load].ty.inner_with(&module.types),
            TypeInner::Struct { .. } | TypeInner::Array { .. }
        )
        && written_after(function, pointer, load)
}

/// The variable a chain of accesses from `pointer` starts at.
#[derive(Clone, Copy, PartialEq)]
enum Root {
    Local(Handle<crate::LocalVariable>),
    Global(Handle<crate::GlobalVariable>),
    Argument(u32),
}

fn root_of(function: &Function, mut pointer: Handle<Expression>) -> Option<Root> {
    loop {
        match function.expressions[pointer] {
            Expression::Access { base, .. } | Expression::AccessIndex { base, .. } => {
                pointer = base;
            }
            Expression::LocalVariable(local) => return Some(Root::Local(local)),
            Expression::GlobalVariable(global) => return Some(Root::Global(global)),
            Expression::FunctionArgument(index) => return Some(Root::Argument(index)),
            _ => return None,
        }
    }
}

/// Whether `function` may write the variable `pointer` reads from after
/// `load` reads it, through a store, a pointer it passes, or for a global any
/// call.
fn written_after(
    function: &Function,
    pointer: Handle<Expression>,
    load: Handle<Expression>,
) -> bool {
    let Some(root) = root_of(function, pointer) else {
        return true;
    };
    writes_after(function, &function.body, root, load, &mut false)
}

fn writes_after(
    function: &Function,
    block: &crate::Block,
    root: Root,
    load: Handle<Expression>,
    after: &mut bool,
) -> bool {
    use crate::Statement;
    for statement in block.iter() {
        let writes = match *statement {
            Statement::Emit(ref range) => {
                *after |= range.clone().any(|handle| handle == load);
                false
            }
            Statement::Store { pointer, .. } => *after && root_of(function, pointer) == Some(root),
            Statement::Call { ref arguments, .. } => {
                *after
                    && (matches!(root, Root::Global(_))
                        || arguments
                            .iter()
                            .any(|&argument| root_of(function, argument) == Some(root)))
            }
            Statement::Block(ref inner) => writes_after(function, inner, root, load, after),
            Statement::If {
                ref accept,
                ref reject,
                ..
            } => {
                writes_after(function, accept, root, load, after)
                    || writes_after(function, reject, root, load, after)
            }
            Statement::Switch { ref cases, .. } => cases
                .iter()
                .any(|case| writes_after(function, &case.body, root, load, after)),
            Statement::Loop {
                ref body,
                ref continuing,
                ..
            } => {
                writes_after(function, body, root, load, after)
                    || writes_after(function, continuing, root, load, after)
            }
            _ => false,
        };
        if writes {
            return true;
        }
    }
    false
}
