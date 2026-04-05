# <font color="green">Area of Triangle</font>

* Write a function `triangle_area` (or `triangleArea`, according to your language's case convention) that takes six 64-bit floating point numbers $x_1$, $y_1$, $x_2$, $y_2$, $x_3$, $y_3$ --- the coordinates of three points in the plane --- and returns the area of the triangle formed by these points.

* In a mathematical expression,

$$
triangle\_area(x_1, y_1, x_2, y_2, x_3, y_3)
=
\frac{{1}}{{2}}
\left|
(x_2 - x_1)(y_3 - y_1)
-
(x_3 - x_1)(y_2 - y_1)
\right|
$$

* Use 64-bit floating point numbers for both inputs and the output.

* Consider introducing necessary local variables to make the computation easier to understand.

* Boilerplate source files `{{go,jl,ml,rs}}/{base}.{{go,jl,ml,rs}}` containing the test code is generated and shown below.

* Edit the source files either by opening them in a text editor (e.g., vscode), or editing the cells below and executing them.
