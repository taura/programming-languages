# <font color="green">Passing many parameters</font>

## Problem

* Write a function `call_many_args(base)` __in assembly__ that calls the (given) twenty-parameter function `add_many` with the arguments `base, base+1, ..., base+19`, and returns its result.
* That is, translate the following C function into assembly:
```
long add_many(long, long, long, long, long, long, long, long, long, long,
              long, long, long, long, long, long, long, long, long, long); /* given */

long call_many_args(long base) {
  return add_many(base, base+1, base+2, base+3, base+4, base+5, base+6, base+7,
                  base+8, base+9, base+10, base+11, base+12, base+13, base+14,
                  base+15, base+16, base+17, base+18, base+19);
}
```
* The first eight arguments go in `x0`–`x7`. The remaining twelve must be written to the stack at `[sp]`, `[sp, 8]`, `[sp, 16]`, ... **before** the `bl add_many`. Remember to reserve that stack space (keeping `sp` 16-byte aligned) and to set up a frame (save `x29`/`x30`) because you make a call.
* Fill in the skeleton `call_many_args.s` (after `// ------- write your answer here -------`).
* The checker `check_call_many_args.c` provides `add_many` and verifies your result. If you see `OK`s and no errors, you are done.

## Hints

* This is the caller's side of the previous problem (*Receiving many parameters*). The same ABI rule applies: the first eight integer arguments are passed in `x0`–`x7`, and the rest on the stack.
* To pass arguments on the stack, the caller reserves space below `sp` and stores the extra arguments at `[sp]`, `[sp, 8]`, ... (the ninth argument at the lowest address). The callee then reads them from those same `sp`-relative locations.
* The *Observe* cells below contain a simple example, `call_add10`, which calls a 10-parameter function with constants (so only the 9th and 10th arguments go on the stack). Compile it and observe how the caller reserves stack space and stores those arguments before the `bl` --- then do the same for twenty arguments, with the values `base, base+1, ...` computed from your argument.
