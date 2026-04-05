# <font color="green">Minimize a Polynomial</font>

* Consider the function

$$
f(x) = x^4 - 3x^3 + 2x^2 + x + 1.
$$

* Write a function `min_value` (or `minValue`) that takes:
  - 64-bit floating point numbers \(a\) and \(b\) with \(a < b\),
  - a 64-bit integer \(n\) (you may assume \(n \ge 1\)),

  and returns an approximation of the minimum value of \(f(x)\) over the interval \([a, b]\).

* Use the sample points

$$
x_i = a + \frac{(b-a)i}{n}, \qquad i = 0,1,\dots,n.
$$

* Return

$$
\min_i f(x_i).
$$

* Use:
  - 64-bit floating point numbers for all real values,
  - an integer for \(n\).

* Boilerplate source files `{go,jl,ml,rs}/minimize_polynomial.{go,jl,ml,rs}` containing the test code is generated and shown below.

* Edit the source files either by opening them in a text editor (e.g., vscode), or editing the cells below and executing them.


