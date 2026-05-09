# <font color="green">Series Summation</font>

* Write a function `series_sum` (or `seriesSum`, according to your language's case convention) that takes a 64-bit integer $n$ (you may assume $n \ge 1$ and returns the value

$$
\sum_{k=1}^{n} \frac{1}{k^2}.
$$

* Use:
  - an integer for $n$,
  - a 64-bit floating point number for the return value.

* Boilerplate source files `{go,jl,ml,rs}/series_sum.{go,jl,ml,rs}` containing the test code is generated and shown below.

* Edit the source files either by opening them in a text editor (e.g., vscode), or editing the cells below and executing them.

## Note

* As $n \rightarrow \infty$, the sum approaches

$$
\frac{\pi^2}{6}.
$$
