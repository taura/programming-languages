# <font color="green">Greatest Common Divisor</font>

* Write a function `gcd` that takes two non-negative integers $a$ and $b$ (not both zero and $a \ge b$) and returns their greatest common divisor.

* Use the recurrence:

$$
\gcd(a, b) =
\begin{cases}
a & \text{if } b = 0 \\
\gcd(b, a \bmod b) & \text{otherwise}
\end{cases}
$$

* Use integers for both input and output.

* Boilerplate source files `{go,jl,ml,rs}/gcd.{go,jl,ml,rs}` containing the test code is generated and shown below.

* Edit the source files either by opening them in a text editor (e.g., vscode), or editing the cells below and executing them.
