# <font color="green">Basic Data Types</font>

- Investigate how basic data types such as integers and floating-point numbers are represented in your language.
- To this end, define a function `add_nums` (or `AddNums` in Go) that takes a few integer parameters and returns their sum plus 123. Compile it to assembly and examine the output.
- **Calling conventions** (also known as the Application Binary Interface, or ABI) determine where parameters are placed at the start of a function and where the return value is placed when the function returns.

## Problems

Make a note of the following:

1. Where are the parameters when the function starts?
2. Where is the return value when the function returns?
3. Add slightly different versions of the function and observe how the generated assembly changes. For example:
   - Change the operator `+` to something else (`-`, `*`, `/`, etc.)
   - Change the number of parameters (what happens when it becomes large?)
   - Change the constant (`123`) (what happens when it becomes very large?)
   - Change the parameter type (floating-point numbers or 32-bit integers)

---

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

---

# <font color="green">Arrays</font>

- Investigate how an array is represented in your language.
- Define a function `get_float_array_elem` that takes an array of floating-point numbers `a` and an integer `i`, and returns the `i`-th element of `a` (analogous to the following C function). Compile it to assembly and examine the output.
- Use the following array types:
  - `[]float64` (slice) in Go
  - `Vector{Float64}` in Julia
  - `float array` in OCaml
  - `Vec<f64>` or `&[f64]` (slice) in Rust

## Problems

Make a note of the following:

1. Locate the instruction that loads the element from memory.
2. How does your language represent the array-like data structure?
3. Compare with other languages in your team and note any notable differences.

---

# <font color="green">If Expressions/Statement</font>

- Investigate how an if-statement or if-expression is compiled.
- To this end, define a function `gcd1` (or `Gcd1` in Go) that takes two integers $a$ and $b$ returns $a$ if $b$ is zero, and $a \mbox{mod} b$ otherwise.

## Problems

Make a note of the following:

1. Locate the instruction to compare $b$ with zero.
1. Locate the conditional branch instruction that jumps to an appropriate instruction based on the result of the comparison.

---

# <font color="green">Loops</font>

- Investigate how a loop is compiled.
- Define a function `sum_array_loop` (or `SumArrayLoop` in Go) that takes an array of floating-point numbers and returns the sum of all its elements. Compile it to assembly and examine the output.
- For OCaml, use a [for loop](https://ocaml.org/docs/loops-recursion) with mutable variables (`ref`).
- Use the following array types:
  - `[]float64` (slice) in Go
  - `Vector{Float64}` in Julia
  - `float array` in OCaml
  - `Vec<f64>` in Rust

## Problems

Make a note of the following:

1. Locate the loop in the assembly code
2. As $n$ tends to infinity, how many instructions are executed per array element?

---

# <font color="green">Function Calls</font>

- Investigate how a function call is compiled from the caller's perspective.
- To this end, define a function `call_tanh` (or `CallTanh` in Go) that takes a floating-point number $x$ and returns $\tanh(x + 1.0) + 2.0$.

## Problems

Make a note of the following:

1. Locate the instruction that calls `tanh` (or an equivalent function).
2. Since the function computes $\tanh(x + 1.0) + 2.0$, the value of `x` must be saved somewhere across the call. Determine how and where it is saved.

---

# <font color="green">How the Stack Grows</font>

- Investigate what happens to the stack during deep recursive calls.
- Define a recursive function `sum_array_rec` (or `SumArrayRec` in Go) that takes an array $a$ and an integer $n$ and computes:

$$\text{sum}(a, n) = \begin{cases} 0 & (n = 0) \\ \text{sum}(a,\, n-1) + a[n-1] & (n > 0) \end{cases}$$

In Julia, use 1-based indexing:

$$\text{sum}(a, n) = \begin{cases} 0 & (n = 0) \\ \text{sum}(a,\, n-1) + a[n] & (n > 0) \end{cases}$$

## Problems

Make a note of the following:

1. How much stack space is allocated per function call, and how is it allocated?
2. What values are saved there?

---

# <font color="green">Tail Recursive Calls</font>

- Investigate what happens with _tail_ recursive calls.
- Define a function `sum_array_tail` (or `SumArrayTail` in Go) that takes an array $a$, two integers $i$ and $n$, and a floating-point accumulator $s$, and returns:

$$s + a[i] + a[i+1] + \cdots + a[n-1]$$ in Go/OCaml/Rust and

$$s + a[i+1] + a[i+2] + \cdots + a[n]$$ in Julia

Write it in a **tail-recursive** style.

## Problems

Make a note of the following:

1. Does the compiler successfully eliminate stack growth (i.e., does it perform tail-call optimization)?

---

# <font color="green">Memory Allocation</font>

- Investigate how memory is allocated for various kinds of data.
- Define a function that allocates various data (structs, arrays, objects, etc.), compile it, and examine the output.

## Problems

Make a note of the following:

1. Is the data allocated on the stack or on the heap?

---

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

---

# <font color="green">Your Own Investigation</font>

- Pick any language construct or feature not covered above and investigate how it is compiled.
- You could investigate a feature unique to your language or one shared across several languages.
- Write the code and a description of what you investigated below.


