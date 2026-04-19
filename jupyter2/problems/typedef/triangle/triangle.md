# <font color="green">Area of triangle</font>

* Define a data type, `vec2` (or `Vec2`) that represents a 2-element vector,
* write a function `vec2_minus` (or `vec2Minus`) that takes two vectors $a$ and $b$ and returns another vector $a - b$,
* write a function `cross` that takes two vectors $a = (a_0, a_1)$ and $b = (b_0, b_1)$ and returns their cross-product ($a_0 b_1 - a_1 b_0$)
* define a data type, `triangle` (or `Triangle`) that represents a triangle, consisting of three vertices, 
* define a function `area_of_triangle` that takes a triangle and returns its area, and
* define a function `check` that takes seven floating point numbers $x_0$, $y_0$, $x_1$, $y_1$, $x_2$, $y_2$, and $a$ that makes a triangle whose vertices are $(x_0, y_0)$, $(x_1, y_1)$, and $(x_2, y_2)$, finds its area, and returns if the difference between the computed area and $a$ is $< 10^{-6}$.

* Boilerplate source files `{go,jl,ml,rs}/triangle.{go,jl,ml,rs}` containing the test code is generated and shown below.

* Edit the source files either by opening them in a text editor (e.g., vscode), or editing the cells below and executing them.
