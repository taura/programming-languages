# <font color="green">Loops (sum of a long array)</font>

## Problem

* Write a function `sum_array_long(a, n)` that computes the sum of an `n`-element array of `long`s `a`, __in assembly__.
* That is, translate the following C function into assembly:
```
long sum_array_long(long * a, long n) {
  long s = 0;
  for (long i = 0; i < n; i++) { s += a[i]; }
  return s;
}
```
* Fill in the skeleton `sum_array_long.s` (after `// ------- write your answer here -------`).
* The checker `check_sum_array_long.c` verifies your result. If you see `OK`s and no errors, you are done.

## Hints

* In assembly, loops are made of comparisons and conditional branches, just like the `if` statements you saw in the previous problems.
* The *Observe* cells below contain `fact`, which uses a `while` loop. Compile it and locate the loop body, the increment, the comparison, and the branch back to the top.
* In general,
```
while (condition) S;
```
is equivalent to
```
    goto LC;
LB: S;
LC: c = condition;
    if (c) goto LB;
```
and the following form is also common (and correct):
```
    c = condition;
    if (!c) goto LE;
LB: S;
    c = condition;
    if (c) goto LB;
LE:
```
* A `for` loop is a special case of `while`:
```
for (init ; condition; increment) S;
```
is equivalent to
```
init;
while (condition) { S; increment; }
```
