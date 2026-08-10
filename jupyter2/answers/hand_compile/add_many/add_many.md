# <font color="green">Receiving many parameters</font>

## Problem

* Write a function `add_many` that takes **twenty** `long` parameters and returns their sum, __in assembly__.
* That is, translate the following C function into assembly:
```
long add_many(long a00, long a01, long a02, long a03, long a04,
              long a05, long a06, long a07, long a08, long a09,
              long a10, long a11, long a12, long a13, long a14,
              long a15, long a16, long a17, long a18, long a19) {
  return a00 + a01 + a02 + a03 + a04 + a05 + a06 + a07 + a08 + a09
       + a10 + a11 + a12 + a13 + a14 + a15 + a16 + a17 + a18 + a19;
}
```
* The first eight parameters arrive in registers `x0`–`x7`. The remaining twelve are passed on the stack; read them with `ldr` from `sp`-relative addresses (`[sp]`, `[sp, 8]`, `[sp, 16]`, ...), since this function makes no call and does not move `sp`.
* Fill in the skeleton `add_many.s` (after `// ------- write your answer here -------`).
* The checker `check_add_many.c` verifies your result. If you see `OK`s and no errors, you are done.

## Hints

* There are only so many registers, so you cannot pass an arbitrary number of parameters in registers.
* The ARM64 ABI passes the first eight integer arguments in `x0`–`x7`; the ninth and later arrive on the **stack**, at `[sp]`, `[sp, 8]`, `[sp, 16]`, ... as seen on entry to the function.
* The *Observe* cells below contain `add_many` itself. Compile it and confirm how the later arguments are read from `sp`-relative addresses.
