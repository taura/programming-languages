# <font color="green">Receiving many parameters</font>

## Problem

* Write a function `many_args` that takes **twenty** `long` parameters but uses only two of them: it returns `a08 * 1000 + a15`, __in assembly__.
* That is, translate the following C function into assembly:
```
long many_args(long a00, long a01, long a02, long a03, long a04,
                long a05, long a06, long a07, long a08, long a09,
                long a10, long a11, long a12, long a13, long a14,
                long a15, long a16, long a17, long a18, long a19) {
  return a08 * 1000 + a15;
}
```
* The first eight parameters (`a00`–`a07`) arrive in registers `x0`–`x7`. The ones you need here are **passed on the stack**, because they come after the first eight:
  * `a08` is the first stack argument, at `[sp]`;
  * `a15` is the eighth stack argument, at `[sp, 56]` (that is, `[sp, 8*(15-8)]`).
* So you only need to load those two with `ldr`, do one multiply and one add, and return. Be careful to use the **correct** offsets --- using the wrong argument will give the wrong answer.
* Fill in the skeleton `many_args.s` (after `// ------- write your answer here -------`).
* The checker `check_many_args.c` verifies your result. If you see `OK`s and no errors, you are done.

## Hints

* There are only so many registers, so you cannot pass an arbitrary number of parameters in registers.
* The ARM64 ABI passes the first eight integer arguments in `x0`–`x7`; the ninth and later arrive on the **stack**, at `[sp]`, `[sp, 8]`, `[sp, 16]`, ... as seen on entry to the function. So `a08` is at `[sp]`, `a09` at `[sp, 8]`, ..., `a15` at `[sp, 56]`.
* The *Observe* cells below contain a simple example, `sum_last2`, which returns the sum of its 9th and 10th parameters (`a8` at `[sp]`, `a9` at `[sp, 8]`). Compile it and see how stack-passed arguments are read with `ldr` --- then apply the same idea to the two arguments this problem needs.
