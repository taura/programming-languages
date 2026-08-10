# <font color="green">Function calls (exp(x) + exp(-x))</font>

## Problem

* Write a function `expsum` that takes a `double` $x$ and computes
$$ \mbox{expsum}(x) = \exp(x) + \exp(-x) $$
* Note that you need to call `exp` twice. After the first call `exp(x)` returns, the argument `x` is no longer in `d0`, so you must arrange to still have `x` (or `-x`) available to compute the second call. Save what you need across the first call.
* That is, translate the following C function into assembly:
```
double expsum(double x) {
  return exp(x) + exp(-x);
}
```
* Fill in the skeleton `expsum.s` (after `// ------- write your answer here -------`). You will need to call `exp` from the math library.
* The checker `check_expsum.c` verifies your result (it is linked with `-lm`). If you see `OK`s and no errors, you are done.

## Hints

* If a function calls another function, its assembly becomes more complex, because:
  * calling a function with `bl` overwrites `x30` (the link register), so `x30` must be preserved on the stack;
  * that means the stack (`sp`) must be extended and the frame pointer (`x29`) set, so `x29` must be preserved too.
* In summary, a function that makes a call typically does something like
```
        stp     x29, x30, [sp, -16]!
```
to extend the stack and preserve `x29` and `x30` before the call, and restores them before returning.
* A key subtlety: a call may overwrite registers (including the argument register `d0`). So if you still need a value *after* the call, you must save it somewhere that survives the call --- typically on the stack, or in a callee-saved register. This problem is designed to exercise exactly that.
* The *Observe* cells below contain `sigmoid.c`. Compile it and look at how the stack frame is set up and how `exp` is called with `bl`.
* For details, study how a function call works in the [How Programming Languages Work (Basics)](https://taura.github.io/programming-languages/slides/05-implementation-basics.pdf) slide deck.
