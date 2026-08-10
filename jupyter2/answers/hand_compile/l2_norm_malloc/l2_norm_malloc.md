# <font color="green">Heap allocation (malloc, then call)</font>

## Problem

* Write a function `l2_norm_malloc(a, b, c)` __in assembly__ that allocates an array of three `long`s on the heap, stores `a, b, c` into it, passes it to the (given) function `l2_norm_long`, frees the array, and returns the result.
* That is, translate the following C function into assembly:
```
long l2_norm_long(long * x);   /* given; computes x[0]*x[0]+x[1]*x[1]+x[2]*x[2] */

long l2_norm_malloc(long a, long b, long c) {
  long * x = (long *) malloc(3 * sizeof(long));
  x[0] = a; x[1] = b; x[2] = c;
  long r = l2_norm_long(x);
  free(x);
  return r;
}
```
* You will call three functions: `malloc`, `l2_norm_long`, and `free`. Remember to save across each call whatever you still need afterwards (the arguments before `malloc`; the pointer `x` until `free`; the result `r` across `free`).
* Fill in the skeleton `l2_norm_malloc.s` (after `// ------- write your answer here -------`).
* The checker `check_l2_norm_malloc.c` provides `l2_norm_long` and verifies your result. If you see `OK`s and no errors, you are done.

## Hints

* In the previous problem the pointer came from a local (stack) array. Another common source is the **heap**: you ask `malloc` for some memory and it returns a pointer to it.
* The *Observe* cells below contain `make3`, which mallocs space for three `long`s and stores into it. Compile it and pay attention to one subtle point:
  * the incoming arguments arrive in `x0, x1, x2`;
  * calling `malloc` returns its result in `x0` and is free to clobber the argument registers;
  * therefore the values you still need *after* the call (here `a, b, c`) must be **saved across the call** (on the stack or in callee-saved registers) before calling `malloc`.
