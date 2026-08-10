# <font color="green">Pointers (square norm)</font>

## Problem

* Write a function `l2_norm_long` in assembly that computes the square norm of a three-element vector of `long`s.
* That is, translate the following C function into assembly:
```
long l2_norm_long(long * x) {
    return x[0] * x[0] + x[1] * x[1] + x[2] * x[2];
}
```
* Fill in the skeleton `l2_norm_long.s` (after `// ------- write your answer here -------`).
* The checker `check_l2_norm_long.c` verifies your result. If you see `OK`s and no errors, you are done.
* Here the pointer `x` is simply given to you. In the next two problems (*Local arrays on the stack* and *Heap allocation*) you will see where such a pointer comes from --- the stack and the heap --- and pass it to this very function.

## Hints

* Motto: "pointers are just integers and nothing more than that".
* **Pointer dereferencing.** The *Observe* cells below contain `long_ptr_deref` (which simply returns `*p`). What is generated for `*p` is
```
        ldr     x0, [x0]
```
a _load instruction_ that reads the eight bytes at the address in `x0` and puts the value in `x0`. So: a pointer parameter `p` is passed in `x0` like an integer; a pointer value is in fact an address (an integer at the assembly level); and dereferencing `p` uses a load.
* **Accessing an array element = pointer dereferencing.** The *Observe* cells also contain `array_index_long` (returning `p[0] + p[10]`). What is generated for `p[0] + p[10]` is
```
        ldr     x1, [x0]
        ldr     x0, [x0, 80]
        add     x0, x1, x0
```
The `+ 80` offset is because a single `long` takes eight bytes (10 × 8 = 80). Note that `*p` and `p[0]` end up using the same instruction --- this is where "arrays are pointers" comes from. For pointers to `int` (4 bytes), the destination registers become `w` registers and the offset for `p[10]` becomes 40.
* This problem just needs the array-indexing pattern: load `x[0]`, `x[1]`, `x[2]` (offsets 0, 8, 16), multiply each by itself, and add.
