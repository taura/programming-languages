# <font color="green">Normal distribution</font>

## Background : Function calls

* If a function calls another function, its assembly becomes more complex, because:
  * calling a function with `bl` overwrites `x30` (the link register), so `x30` must be preserved on the stack;
  * that means the stack (`sp`) must be extended and the frame pointer (`x29`) set, so `x29` must be preserved too.
* In summary, a function that makes a call typically does something like
```
        stp     x29, x30, [sp, -16]!
```
to extend the stack and preserve `x29` and `x30` before the call, and restores them before returning.
* Observe this with `sigmoid.c`:
```
#include <math.h>
double sigmoid(double x) {
  return 1.0 / (1.0 + exp(-x));
}
```
compiled with `gcc -O3 -S sigmoid.c; cat sigmoid.s`.
* For details, study how a function call works in the [How Programming Languages Work (Basics)](https://taura.github.io/programming-languages/slides/05-implementation-basics.pdf) slide deck.

## A general framework for hand-compilation

* The problems below are too complex to tackle without a general framework. The main gaps between high-level languages and assembly are:
  * assembly has no structured compound statements, only branch instructions (≈ goto);
  * assembly does not allow nested expressions;
  * assembly has no new variables, only a fixed number of fixed-name variables (registers).
* Filling all three gaps at once is overwhelming. Instead, convert the program one step at a time:
  * convert loops and `if` statements into `goto`s;
  * break nested expressions into a series of simple assignments (`a * x + b * y` → `s = a * x; t = b * y; u = s + t`);
  * assign registers to variables.
* Also, when you call a function, save values you need after the call onto the stack.

## Problem

* Write a function `normal` that takes a floating-point (`double`) number $x$ and computes
$$ \mbox{normal}(x) \equiv \frac{1}{\sqrt{2\pi}}\exp(-x^2/2) $$
* To obtain $\pi$, use $\pi/4 = \mbox{atan2}(1.0, 1.0)$, i.e.
$$ \mbox{normal}(x) = \frac{1}{\sqrt{8 \;\mbox{atan2}(1.0, 1.0)}} \exp(-x^2/2) $$
* Fill in the skeleton `normal.s` (after `// ------- write your answer here -------`). You will need to call `exp`, `sqrt`, and `atan2` from the math library.
* The checker `check_normal.c` verifies your result (it is linked with `-lm`). If you see `OK`s and no errors, you are done.
