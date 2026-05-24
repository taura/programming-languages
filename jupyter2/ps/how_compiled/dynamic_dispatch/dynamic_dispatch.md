# <font color="green">Dynamic Dispatch</font>

- Investigate how dynamic dispatch is implemented.
- Define a function that takes an object whose concrete type is not known at compile time and calls an `area` method on it.
- Use the following mechanisms:
  - `interface` in Go
  - an abstract type in Julia
  - the object type in OCaml
  - a `trait` object in Rust

# Problem

Make a note of the following

1. What is the mechanism used in the language that determines the function to be called, despite it does not know the exact type of the data?

