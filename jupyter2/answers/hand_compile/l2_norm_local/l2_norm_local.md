# <font color="green">Local arrays on the stack (then call)</font>

## Problem

* Write a function `l2_norm_local(a, b, c)` __in assembly__ that creates a local (stack) array of three `long`s, stores `a, b, c` into it, and returns `l2_norm_long` of it.
* That is, translate the following C function into assembly:
```
long l2_norm_long(long * x);   /* given; computes x[0]*x[0]+x[1]*x[1]+x[2]*x[2] */

long l2_norm_local(long a, long b, long c) {
  long x[3];
  x[0] = a; x[1] = b; x[2] = c;
  return l2_norm_long(x);
}
```
* Remember to keep the stack 16-byte aligned, and to save `x30` (and set up a frame) because you make a call.
* Fill in the skeleton `l2_norm_local.s` (after `// ------- write your answer here -------`).
* The checker `check_l2_norm_local.c` provides `l2_norm_long` and verifies your result. If you see `OK`s and no errors, you are done.

## Hints

* In the *Square norm* problem you were given a pointer. But where do such pointers come from? One common source is a **local array**: an array declared inside a function lives on the stack, and its address can be passed to other functions.
* No function call is needed to allocate it --- the function simply reserves extra space on the stack (by subtracting from `sp`) and the array occupies that space.
* The *Observe* cells below contain `demo_local`, which declares a local array, fills it, and passes it to another function. Compile it and observe:
  * stack space is reserved with something like `sub sp, sp, #...` in the prologue (and released in the epilogue);
  * the address of the local array is formed from `sp` (e.g. `mov x0, sp` or `add x0, sp, #offset`) and passed in `x0`;
  * because the array's address is taken and handed to another function, the values must really live in memory (not just in registers).
