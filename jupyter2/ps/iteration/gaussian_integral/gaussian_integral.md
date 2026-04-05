# <font color="green">Gaussian Integral Approximation</font>

* Write a function `gaussian_integral` (or `gaussianIntegral` depending on the language's case convention) that takes:
  - a 64-bit floating point number $a$ (you may assume $a > 0$),
  - a 64-bit integer $n$ (you may assume $n \ge 1$),

  and returns an approximation of

$$
\int_{{-a}}^{{a}} e^{{-x^2}} \, dx
$$

using $n$ equal-width subintervals and the left-endpoint Riemann sum.

* Let

$$
\Delta x = \frac{{2a}}{{n}}
$$

and approximate the integral by

$$
\sum_{{i=0}}^{{n-1}} e^{{-x_i^2}} \, \Delta x,
\quad
x_i = -a + i \Delta x.
$$

* Use:
  - 64-bit floating point numbers for $a$ and the return value,
  - an integer for $n$.

## Note

As $a$ becomes large, this value approaches $\sqrt{{\pi}}$.

* Boilerplate source files `{{go,jl,ml,rs}}/{base}.{{go,jl,ml,rs}}` containing the test code is generated and shown below.

* Edit the source files either by opening them in a text editor (e.g., vscode), or editing the cells below and executing them.
