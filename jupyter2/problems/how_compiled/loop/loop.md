# <font color="green">Loops</font>

- Investigate how a loop is compiled.
- Define a function `sum_array_loop` (or `SumArrayLoop` in Go) that takes an array of floating-point numbers and returns the sum of all its elements. Compile it to assembly and examine the output.
- For OCaml, use a [for loop](https://ocaml.org/docs/loops-recursion) with mutable variables (`ref`).
- Use the following array types:
  - `[]float64` (slice) in Go
  - `Vector{Float64}` in Julia
  - `float array` in OCaml
  - `Vec<f64>` in Rust
- If available, try different ways to scan the array

## Problems

Make a note of the following:

1. Locate the loop in the assembly code
2. As $n$ tends to infinity, how many instructions are executed per array element?

