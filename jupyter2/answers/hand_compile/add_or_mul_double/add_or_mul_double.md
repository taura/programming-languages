# <font color="green">Conditional select, floating-point (add or multiply)</font>

## Problem

* Write a function `add_or_mul_double` __in assembly__: the floating-point counterpart of `add_or_mul_long`. Use a conditional select (`fcsel`) instead of a conditional branch.
* That is, translate the following C function into assembly:
```
double add_or_mul_double(double x, double y, double z) {
  if (x < y) { return y + z; } else { return y * z; }
}
```
* Compute both `y + z` and `y * z` (with `fadd` and `fmul`), then select the result with `fcsel` according to the floating-point comparison of `x` and `y`.
* Fill in the skeleton `add_or_mul_double.s` (after `// ------- write your answer here -------`).
* The checker `check_add_or_mul_double.c` verifies your result (within a small tolerance). If you see `OK`s and no errors, you are done.

## Hints

* This is the same shape as `add_or_mul_long`, but with `double`s: comparing floating-point numbers uses `fcmp`/`fcmpe` (not the integer `cmp`), and the branchless select is `fcsel` (not `csel`).
* The *Observe* cells below contain a simple example, `cmp_sign` (returns `1.0` if `a > b`, else `-1.0`). Compile it and observe `fcmp`/`fcmpe` followed by `fcsel` choosing between two candidate results.
* So: put `y + z` in one register and `y * z` in another, compare `x` and `y` with `fcmp`, then `fcsel` the right one --- no branch.
