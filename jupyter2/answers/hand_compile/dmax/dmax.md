# <font color="green">Floating-point comparison (max of two doubles)</font>

## Problem

* Write a function `dmax` that returns the larger of two `double` values, __in assembly__.
* You may use either a conditional branch or a conditional select (`fcsel`); the point is to compare the two floating-point numbers with `fcmp`/`fcmpe`.
* That is, translate the following C function into assembly:
```
double dmax(double a, double b) {
  if (a > b) { return a; } else { return b; }
}
```
* Fill in the skeleton `dmax.s` (after `// ------- write your answer here -------`).
* The checker `check_dmax.c` verifies your result. If you see `OK`s and no errors, you are done.

## Hints

* Comparing floating-point numbers uses different instructions from integer comparison. You do not need to memorize them --- let `gcc -S` show you the instruction name and look it up.
* The *Observe* cells below contain a simple example, `cmp_sign` (returns `1.0` if `a > b`, else `-1.0`). Compile it and observe that `fcmp`/`fcmpe` is the comparison instruction (the floating-point counterpart of `cmp`), followed by a conditional select (`fcsel`). This problem uses the same comparison, but selects between `a` and `b` themselves.
* Note: if you write a plain `a > b ? a : b` in C, the compiler folds it into a single `fmaxnm` instruction; that is why the example above returns two distinct constants, to keep the `fcmp` + `fcsel` pattern visible. For your hand-written answer, an explicit `fcmp` + `fcsel` (or a branch) is perfectly fine.
