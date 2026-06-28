# <font color="green">Inner product (dot product)</font>

## Problem

* Write a function `inner_prod_double(p, q, n)` that computes the inner (dot) product of two `n`-element arrays of `double`s, `p` and `q`, __in assembly__.
* That is, translate the following C function into assembly:
```
double inner_prod_double(double * p, double * q, long n) {
  double s = 0.0;
  for (long i = 0; i < n; i++) {
    s += p[i] * q[i];
  }
  return s;
}
```
* Fill in the skeleton `inner_prod_double.s` (after `// ------- write your answer here -------`).
* The checker `check_inner_prod_double.c` verifies your result (within a small tolerance). If you see `OK`s and no errors, you are done.

## Hints

* This is a loop, like *Sum of a long array*, but with floating-point values and **two** arrays.
* The *Observe* cells below contain a simple example, `sum_one`, which loops over a single array accumulating a sum. Compile it and see the load, the `fadd` into the accumulator, and the loop back-edge.
* For this problem, each iteration loads `p[i]` and `q[i]` (advancing both pointers, or indexing with `i`), multiplies them with `fmul` (or uses the fused multiply-add `fmadd`), and adds the product to the running sum. The pointers `p` and `q` arrive in `x0` and `x1`, and `n` in `x2`.
