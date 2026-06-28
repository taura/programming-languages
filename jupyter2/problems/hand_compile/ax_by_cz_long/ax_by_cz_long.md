# <font color="green">Integer arithmetic (ax + by + cz)</font>

## Problem

* Write a function `ax_by_cz_long` that returns `a*x + b*y + c*z` for given `long` inputs `a, x, b, y, c, z`, __in assembly__.
* That is, translate the following C function into assembly:
```
long ax_by_cz_long(long a, long x, long b, long y, long c, long z) {
  return a * x + b * y + c * z;
}
```
* Fill in the skeleton `ax_by_cz_long.s` (after `// ------- write your answer here -------`) with instructions.
* The checker `check_ax_by_cz_long.c` compares your result against the value computed in C. If you see `OK`s and no errors, you are done.

## Hints

* The *Observe* cells below contain some simple integer functions (`add`, `sub`, `mul`). Compile them and observe:
  * parameters are passed following the ARM64 ABI (the first integer parameters go in `x0, x1, x2, ...`);
  * the return value follows the ABI too (an integer is returned in `x0`);
  * there are instructions corresponding to integer arithmetic (`add`, `sub`, `mul`).

