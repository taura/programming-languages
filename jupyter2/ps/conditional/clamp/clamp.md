# <font color="green">Value Clamping</font>

* Write a function `clamp` (or `Clamp`, according to your language's case convention) that takes three 64-bit floating point numbers `x`, `low`, and `high`, and returns `x` clamped to the interval `[low, high]`.

* In other words:

$$
{{\rm clamp}}(x, low, high) =
\begin{{cases}}
low  & (x < low) \\
high & (x > high) \\
x    & \text{{otherwise}}
\end{{cases}}
$$

* Boilerplate source files `{{go,jl,ml,rs}}/{base}.{{go,jl,ml,rs}}` containing the test code is generated and shown below.

* Edit the source files either by opening them in a text editor (e.g., vscode), or editing the cells below and executing them.
