# <font color="green">Structs</font>

- Investigate how a composite data type such as `struct` in Go/Julia/Rust and variant/record in OCaml is represented in your language.
- To this end, define a type `Point` (or `point`) that has two fields `x` and `y`, both 64-bit floating-point numbers. Then define a function `get_point_y` (or `GetPointY` in Go) that takes a `Point` (or a pointer to one) and returns its `y` field. Compile it to assembly and examine the output.
- For `Point`, use:
  - `struct` in Go, Julia, and Rust
  - a variant in OCaml

## Problems

Make a note of the following:

1. How does your language represent `Point`?
2. Add slightly different versions of the function such as those taking a pointer (or a reference) and observe how they are represented.  Specifically,
   * `*Point` in Go
   * `&Point` and `Box<Point>` in Rust

