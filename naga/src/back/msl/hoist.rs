/*!
Finding temporaries that must be declared outside a loop.

Naga IR's [`Loop`] statement runs its `continuing` block after its `body`, but
MSL has no equivalent construct, so [`Writer::put_block`] emits the `continuing`
block at the *top* of a `while` loop, skipped on the first iteration:

```ignore
bool loop_init = true;
while(true) {
    if (!loop_init) {
        <continuing>
        if (<break_if>) { break; }
    }
    loop_init = false;
    <body>
}
```

Expressions emitted in `body` are in scope in `continuing`, but the temporaries
holding their values are declared *below* the generated `continuing` code, so
they can't be named there. Re-evaluating such an expression in place would use
the state at the end of the loop iteration, which may have changed from the
state at the original position.

So when a loop has a `continuing` block, we declare the temporaries the
`continuing` block needs ahead of the `while` loop, and have the body merely
assign to them.

[`Loop`]: crate::Statement::Loop
[`Writer::put_block`]: super::writer::Writer::put_block
*/

use core::fmt::Write;

use super::{writer::StatementContext, BackendResult, Writer};
use crate::{
    arena::Handle,
    back::{self, continuing::continuing_dependencies},
};

impl<W: Write> Writer<W> {
    /// Declare the temporaries that a loop's `continuing` block needs ahead of
    /// the loop.
    ///
    /// Record them in [`Self::hoisted_loop_expressions`], so that `continuing` can
    /// name them and the body assigns to them rather than declaring them. Each
    /// entry is moved to [`Self::named_expressions`] when the body writes the
    /// expression's definition, which it always does, since every candidate
    /// comes from a statement in `body`.
    ///
    /// See [the module documentation](self) for why this is needed.
    pub(super) fn hoist_continuing_dependencies(
        &mut self,
        level: back::Level,
        body: &crate::Block,
        continuing: &crate::Block,
        break_if: Option<Handle<crate::Expression>>,
        context: &StatementContext,
    ) -> BackendResult {
        let context = &context.expression;
        let hoisted = continuing_dependencies(
            context.module,
            context.function,
            context.info,
            body,
            continuing,
            break_if,
            |handle| self.bakes_expression(handle, context),
        );
        for handle in hoisted {
            let Some(name) = self.baked_name(handle, context) else {
                continue;
            };

            write!(self.out, "{level}")?;
            self.put_baked_type(handle, context)?;
            writeln!(self.out, " {name} = {{}};")?;

            self.hoisted_loop_expressions.insert(handle, name);
        }

        Ok(())
    }
}
