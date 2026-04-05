# <font color="green">Point-Line Distance</font>

* Write a function `point_line_distance` (or `pointLineDistance`, according to your language's case convention) that takes six 64-bit floating point numbers:
  * $x_0$, $y_0$, $x_1$, $y_1$ --- coordinates of two distinct points $(x_0, y_0)$ and $(x_1, y_1)$ on a line
  * $p$, $q$ --- the coordinates of a point $(p, q)$
and returns the distance from the point to the line through $(x_0, y_0)$ and $(x_1, y_1)$.

* Consider introducing local variables to break the computation into several steps.

* Hint 1: the distance between line $ax + by + c = 0$ and point $(p, q)$ is 

$$ \frac{|ap + bq + c|}{ \sqrt{a^2 + b^2} }. $$

* Hint 2: For line $ax + by + c = 0$, $(a, b)$ is perpendicular to the line.  That is, it is perpendicular to $(x_1 - x_0, y_1 - y_0)$.

* Use 64-bit floating point numbers for both inputs and the output.

* Boilerplate source files `{go,jl,ml,rs}/point_line_distance.{go,jl,ml,rs}` containing the test code is generated and shown below.

* Edit the source files either by opening them in a text editor (e.g., vscode), or editing the cells below and executing them.
