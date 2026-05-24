# <font color="green">Arrays</font>

- Investigate how an array is represented in your language.
- Define a function `get_array_elem` that takes an array of floating-point numbers `a` and an integer `i`, and returns the `i`-th element of `a`. Compile it to assembly and examine the output.
- Examine a few variations of how exactly the array is passed
- Use the following array types:
  - `[3]float64` (3-element array) and `[]float64` (slice) in Go
  - `Vector{{Float64}}` in Julia
  - `float array` in OCaml
  - `Vec<f64>`, `&[f64; 3]` (3-element array), and `&[f64]` (slice) in Rust

## Problems

Make a note of the following:

1. Locate the instruction that loads the element from memory.
2. How does your language represent those array-like data structures?

