# <font color="green">Gaussian Density</font>

* Write a function `gaussian_density` (or `gaussianDensity`, according to your language's case convention) that takes $\mu$ (mu, representing the mean), $\sigma$ (sigma, representing the standard deviation), and $x$, and returns the value of the Gaussian (normal) probability density function at $x$:

$$
\frac{1}{ \sqrt{2\pi}\,\sigma } \exp\!\left(-\frac{ (x-\mu)^2} {2\sigma^2} \right)
$$

* Use 64-bit floating point numbers for $x$, $\mu$, and $\sigma$.

* Consider introducing local variables appropriately, to avoid making a single expression too large to read.

* Boilerplate source files `{go,jl,ml,rs}/gaussian_density.{go,jl,ml,rs}` containing the test code is generated and shown below.

* Edit the source files either by opening them in a text editor (e.g., vscode), or editing the cells below and executing them.
