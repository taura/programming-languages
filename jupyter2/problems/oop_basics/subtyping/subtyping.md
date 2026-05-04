# <font color="green">Subtyping</font>

- In the previous two problems you saw that all four languages support *polymorphism*: a single variable or expression can refer to a rectangle at one point and an ellipse at another.
- In those examples, however, the two types had *identical interfaces* --- the same set of method names with the same parameter and return types.
- This problem presents a more interesting case: two types with *different* sets of methods that can nonetheless be assigned to a single variable, passed to a single function, and stored in a single collection.
- When such substitutions are allowed is precisely what the notion of _subtype_ captures.

## <font color="green">Problem</font>

- Define two classes, `ellipse` and `rect`, representing an ellipse and a rectangle placed at a specific location.
- Each class should provide, in addition to the `area` method defined earlier for `free_ellipse` and `free_rect`, a `contains` method that takes $x$ and $y$ and returns whether the point $(x, y)$ lies inside the shape.
- As in previous problems, define constructor functions `mk_ellipse` and `mk_rect`:
  - `mk_ellipse` takes $a$, $b$, $x_0$, and $y_0$ (all floating-point, in that order) and returns an ellipse centered at $(x_0, y_0)$.
  - `mk_rect` takes $w$, $h$, $x_0$, and $y_0$ (all floating-point, in that order) and returns a rectangle whose upper-left corner is at $(x_0, y_0)$.
  - **Note:** The term *upper-left* follows the computer-graphics convention in which the y-axis points downward and the x-axis points right, but the exact convention does not matter unless you are rendering on screen.  In this problem, this simply means $x_0$ is the minimum x-coordinate and $y_0$ the minimum y-coordinate.
- Some languages let you avoid repeating field definitions and the `area` implementation in `ellipse` and `rect`; others require it. You need not go out of your way to eliminate the repetition.
- Define both classes so that a single implementation of `smaller` can accept `ellipse` or `rect` in addition to `free_ellipse` and `free_rect`.
- Define a function `mk_shapes` that returns a sequence containing the following shapes in order (you may copy them from the test code in the main function):
  - an ellipse with horizontal radius $16.0$, vertical radius $5.0$, and center $(-15.0, -4.0)$
  - a rectangle with width $16.0$, height $5.0$, and upper-left vertex $(-15.0, -4.0)$
  - an ellipse with horizontal radius $6.0$, vertical radius $3.0$, and center $(-3.0, -2.0)$
  - a rectangle with width $6.0$, height $3.0$, and upper-left vertex $(-3.0, -2.0)$
- Define a function `mk_mixed_shapes` that returns a sequence concatenating the result of `mk_free_shapes` and `mk_shapes`
- Define a function `count_contains` that takes a (potentially mixed) sequence of `ellipse`s and `rect`s together with coordinates $x$ and $y$, and returns the number of shapes that contain the point $(x, y)$.
- What happens if you pass the result of `mk_free_shapes` or `mk_mixed_shapes` to `count_contains` in each language?
    - type error at compile time
    - type error at runtime
    - no errors
- What happens if you pass the result of `mk_free_shapes`, `mk_shapes`, and `mk_mixed_shapes` to `sum_area`?
    - type error at compile time
    - type error at runtime
    - no errors
- What rules govern the language's behavior here? 
- <font color="green">Q: Discuss above points with your team members</font>
- Boilerplate source files `{go,jl,ml,rs}/{base}.{go,jl,ml,rs}` containing the test code are generated and shown below.
- Edit the source files either by opening them in a text editor (e.g., VS Code) or by editing and executing the cells below.

