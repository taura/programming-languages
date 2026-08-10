# <font color="green">Conditional select (add or multiply)</font>

## Problem

* Write a function `add_or_mul_long` __in assembly__, using a conditional select (`csel`) instead of a conditional branch.
* That is, translate the following C function into assembly:
```
long add_or_mul_long(long x, long y, long z) {
  if (x < y) { return y + z; } else { return y * z; }
}
```
* Compute both `y + z` and `y * z`, then select the result with `csel` according to the comparison of `x` and `y`.
* Fill in the skeleton `add_or_mul_long.s` (after `// ------- write your answer here -------`).
* The checker `check_add_or_mul_long.c` verifies your result. If you see `OK`s and no errors, you are done.

## Hints

* Superscalar processors decode instructions far ahead of the one currently executing. When they hit a branch, they *predict* its outcome; a misprediction forces the processor to roll back, which is costly.
* As such, compilers avoid branch instructions where profitable and use _conditional instructions_ instead.
* The *Observe* cells below contain `imax` (the maximum of two values). Compile it and notice that the compiler does **not** branch: it uses a `cmp` followed by `csel` ("conditional select"), which copies one of two source registers into the destination depending on the comparison.
* The same idea applies to this problem: compute `y + z` into one register and `y * z` into another, then use a single `csel` to keep the right one according to the comparison of `x` and `y` --- no branch at all. Computing both is profitable when both expressions are cheap.
* Related instructions you may see: `cset` (set a register to 0/1 from a condition), `cinc`, `csneg`, etc.
