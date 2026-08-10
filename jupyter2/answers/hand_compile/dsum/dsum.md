# <font color="green">Beating the compiler with SIMD</font>

## Problem

* Write a function `dsum(a, n)` __in assembly__ that returns the sum of an `n`-element array of `double`s, using NEON to process more than one element per iteration.
* That is, compute the same value as this C function, but **faster than `gcc -O3`**:
```
double dsum(double * a, long n) {
  double s = 0.0;
  for (long i = 0; i < n; i++) s += a[i];
  return s;
}
```
* Suggested approach:
  1. zero a vector accumulator `v0.2d`;
  2. loop while at least 2 elements remain: `ld1 {v1.2d}, [x0], #16` then `fadd v0.2d, v0.2d, v1.2d`;
  3. after the loop, reduce with `faddp d0, v0.2d`;
  4. handle the **tail**: if `n` is odd, add the last remaining element.
* For extra speedup, use two or four vector accumulators in the loop and combine them at the end.
* Fill in the skeleton `dsum.s` (after `// ------- write your answer here -------`).
* The checker `check_dsum.c` verifies your result against a scalar reference (within a small tolerance, since the rounding may differ) and also prints a timing comparison. If you see `OK` and a `speedup` greater than 1, you have beaten the compiler.

## Hints

* This problem is the opposite of the others: write assembly that is **faster than what `gcc -O3` produces**, by doing something the compiler is not allowed to do.
* Compile the scalar version (it is in the *Observe* cells below as `dsum_scalar`) and you will see a **serial chain of `fadd`** --- one addition per element into a single accumulator. The compiler keeps the additions serial because floating-point addition is **not associative**: reordering them would change the rounding of the result. Without `-ffast-math`, the compiler is forbidden from changing the answer, so it will not turn this into a parallel (lane-wise) reduction.
* But *you* are allowed to accept a slightly different rounding. So you can:
  * use **SIMD (NEON)** to add several elements at once, and
  * use **several independent accumulators** to break the loop-carried dependency chain (so the CPU can run additions in parallel instead of waiting for each `fadd` to finish before starting the next).
* A few NEON instructions:
  * ARM64 has 128-bit vector registers `v0`–`v31`. Viewed as `.2d` they hold **two** `double`s; viewed as `q` they are a single 128-bit value.
  * `ld1 {v1.2d}, [x0], #16` --- load two `double`s from `[x0]` into `v1`, then advance `x0` by 16 bytes (post-increment).
  * `fadd v0.2d, v0.2d, v1.2d` --- lane-wise add: `v0[0]+=v1[0]` and `v0[1]+=v1[1]`, in parallel.
  * `faddp d0, v0.2d` --- horizontal add: `d0 = v0[0] + v0[1]` (use this once at the end to combine the two lanes).
  * `movi v0.2d, #0` --- zero a vector accumulator.
* The *Observe* cells also contain `dscale`, a loop the compiler **will** auto-vectorize (because each output is independent, with no loop-carried fp dependency) --- a useful contrast.
* This is an **optional, advanced** problem. The point is conceptual: compilers are conservative because they must preserve the exact semantics of your program (here, the exact floating-point rounding). When you know more than the compiler --- e.g. that a slightly different rounding is acceptable --- you can sometimes do better by hand.
