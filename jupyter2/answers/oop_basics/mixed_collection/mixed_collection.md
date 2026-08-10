# <font color="green">Heterogeneous Data</font>

- In the previous problem (`oop_basics/polymorphism`) you defined classes for ellipses and rectangles, and a single function capable of accepting either.
- Just as a function can accept values of multiple types, a collection such as an array or list can also hold values of multiple types.

## <font color="green">Problem</font>

- Define a function `mk_free_shapes` that returns a sequence containing the following shapes in order (you may copy the coordinates from the test code in the main function):
  - an ellipse with horizontal radius $16.0$ and vertical radius $5.0$
  - a rectangle with width $16.0$ and height $5.0$
  - an ellipse with horizontal radius $6.0$ and vertical radius $3.0$
  - a rectangle with width $6.0$ and height $3.0$
- For the sequence, use:
  - a slice in Go,
  - a vector in Julia,
  - a list in OCaml,
  - a vector in Rust.
- Define a function `sum_area` that takes a sequence potentially containing both rectangles and ellipses, and returns the total area of its elements.
- Boilerplate source files `{go,jl,ml,rs}/{base}.{go,jl,ml,rs}` containing the test code are generated and shown below.
- Edit the source files either by opening them in a text editor (e.g., VS Code) or by editing and executing the cells below.

