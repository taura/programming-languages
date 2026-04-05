# <font color="green">Value Clamping</font>

* Write a function `clamp` that takes three 64-bit floating point numbers $x$, $l$, and $h$, and returns $x$ clamped to the interval $[l, h]$.

* In other words:

$$
{\rm clamp}(x, l, h) =
\begin{cases}
l & (x < l) \\
h & (x > h) \\
x & \text{otherwise}
\end{cases}
$$

* Boilerplate source files `{go,jl,ml,rs}/clamp.{go,jl,ml,rs}` containing the test code is generated and shown below.

* Edit the source files either by opening them in a text editor (e.g., vscode), or editing the cells below and executing them.
