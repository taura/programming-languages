# <font color="green">Projectile Height</font>

* A mass point launched from initial height $h_0$ (meters) with initial vertical velocity $v_0$ (m/s). 
* Write a function `height` that takes $h_0$, $v_0$ and time $t$ (seconds) in all 64-bit floating point numbers and returns the height of the mass point at time $t$. 

* In a mathematical expression,

$$ {\rm height}(h_0, v_0, t) = h_0 + v_0 t - \frac{1}{2}gt^2 $$

* where $g = 9.8$ [m/s${}^2$].

* Boilerplate source files `{go,jl,ml,rs}/projectile_height.{go,jl,ml,rs}` containing the test code is generated and shown below.

* Edit the source files either by opening them in a text editor (e.g., vscode), or editing the cells below and executing them.
