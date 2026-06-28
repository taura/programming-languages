# <font color="green">Inner product with SIMD (beating the compiler)</font>

## Problem

* Write a function `inner_prod_simd(p, q, n)` __in assembly__ that computes the inner (dot) product of two `n`-element `double` arrays, using NEON to process more than one element per iteration.
* That is, compute the same value as this C function, but **faster than `gcc -O3`**:
```
double inner_prod_simd(double * p, double * q, long n) {
  double s = 0.0;
  for (long i = 0; i < n; i++) s += p[i] * q[i];
  return s;
}
```
* Suggested approach:
  1. zero a vector accumulator `v0.2d`;
  2. loop while at least 2 elements remain:
     `ld1 {v1.2d}, [x0], #16` ; `ld1 {v2.2d}, [x1], #16` ; `fmla v0.2d, v1.2d, v2.2d`;
  3. after the loop, reduce with `faddp d0, v0.2d`;
  4. handle the **tail**: if `n` is odd, add `p[last]*q[last]`.
* For extra speedup, use two or four vector accumulators and combine them at the end.
* Fill in the skeleton `inner_prod_simd.s` (after `// ------- write your answer here -------`).
* The checker `check_inner_prod_simd.c` verifies your result against a scalar reference (within a small tolerance, since the rounding may differ) and prints a timing comparison. If you see `OK` and a `speedup` greater than 1, you have beaten the compiler.

## Hints

* This is the same computation as *Inner product (dot product)*, but the goal is to be **faster than `gcc -O3`** by doing something the compiler is not allowed to do.
* Compile the scalar version (in the *Observe* cells below as `inner_prod_scalar`) and you will see a **serial chain** accumulating into a single register. The compiler keeps the additions serial because floating-point addition is **not associative**: reordering them would change the rounding. Without `-ffast-math`, it will not turn this into a parallel (lane-wise) reduction.
* But *you* are allowed to accept a slightly different rounding. So you can:
  * use **SIMD (NEON)** to multiply-accumulate several elements at once, and
  * use **several independent accumulators** to break the loop-carried dependency chain.
* A few NEON instructions:
  * `v0`–`v31` are 128-bit vector registers; as `.2d` they hold **two** `double`s.
  * `ld1 {v1.2d}, [x0], #16` --- load two `double`s and advance `x0` by 16 (post-increment).
  * `fmla v0.2d, v1.2d, v2.2d` --- fused multiply-add, lane-wise: `v0[i] += v1[i] * v2[i]`.
  * `faddp d0, v0.2d` --- horizontal add of the two lanes (use once at the end).
  * `movi v0.2d, #0` --- zero a vector accumulator.
* The *Observe* cells also contain `vmul` (`c[i] = p[i]*q[i]`), a loop the compiler **will** auto-vectorize, because each output is independent --- a useful contrast with the reduction.
* This is an **optional, advanced** problem. The point is conceptual: the compiler is conservative because it must preserve the exact floating-point rounding; when you know a slightly different rounding is acceptable, you can do better by hand.
