# <font color="green">Greatest Common Divisor</font>

* Write a function `gcd` that takes two non-negative integers $a$ and $b$ ($a \ge b$, not both zero) and returns their greatest common divisor

* Hint: for $b > 0$:

$$
\gcd(a, b) = \gcd(b, a \bmod b)
$$

* Do not use loops or mutable variables; the observation above should allow you to formulate `gcd` recursively, almost trivially

* If you have worked on `gcd` before (in the iteration topic), which approach do you find easier?

* Boilerplate source files `{go,jl,ml,rs}/gcd.{go,jl,ml,rs}` containing the test code is generated and shown below.

* Edit the source files either by opening them in a text editor (e.g., vscode), or editing the cells below and executing them.
