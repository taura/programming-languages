# <font color="green">Floating-point arithmetic (ax + by + cz)</font>

## Problem

* Write a function `ax_by_cz_double` that returns `a*x + b*y + c*z` for given `double` inputs `a, x, b, y, c, z`, __in assembly__.
* This is the floating-point counterpart of the `ax_by_cz_long` problem: the same expression, but with `double` parameters and results.
* That is, translate the following C function into assembly:
```
double ax_by_cz_double(double a, double x, double b, double y, double c, double z) {
  return a * x + b * y + c * z;
}
```
* Fill in the skeleton `ax_by_cz_double.s` (after `// ------- write your answer here -------`) with instructions.
* The checker `check_ax_by_cz_double.c` compares your result against the value computed in C (within a small tolerance). If you see `OK`s and no errors, you are done.

## Hints

* Floating-point numbers use a separate set of registers and instructions from integers.
* The *Observe* cells below contain some simple floating-point functions (`fadd`, `fsub`, `fmul`). Compile them and observe:
  * floating-point parameters are passed following the ARM64 ABI in the floating-point registers `d0, d1, d2, ...` (distinct from the integer registers `x0, x1, ...`);
  * a floating-point return value is returned in `d0`;
  * arithmetic uses floating-point instructions such as `fadd`, `fsub`, and `fmul` (the `f`-prefixed counterparts of the integer instructions).
