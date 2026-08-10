# <font color="green">The Simplest Polymorphic Functions and Data Structures</font>

* Define a function $f$ that takes a value of *any* type and returns it unchanged (i.e., $f(x) = x$).
* Define a function $g$ that takes a value $x$ of *any* type and returns a single-element sequence (list or array) containing $x$ (i.e., $g(x) = [x]$).
* Define a data type `cell` (or `Cell`) that holds a value of *any* type, with a `get` method that returns the value and a `put(`$x$`)` method that sets it.
* Define a function $h$ that takes a sequence $a$ of *any* type and returns its first element (i.e., $h(a) = a[0]$) if the sequence is non-empty, or a sentinel value indicating absence otherwise.

* For the sequence type, use:
  * a slice in Go
  * `Vector` in Julia
  * `list` in OCaml
  * `Vec` or a slice in Rust

|      |                      |
|------|----------------------|
|Go    |[slice](https://www.tutorialspoint.com/go/go_slice.htm)|
|Julia |[Vector](https://syl1.gitbook.io/julia-language-a-concise-tutorial/language-core/data-types#arrays-lists)|
|OCaml |[list](https://ocaml.org/docs/tour-of-ocaml#lists)|
|Rust  |[Vec](https://www.tutorialspoint.com/article/vectors-in-rust-programming)|
|Rust  |[slice](https://www.tutorialspoint.com/rust/rust_slices.htm)|

* To define the `cell` data type, use:
  * `struct` in Go
  * `struct` in Julia
  * `class` (object) in OCaml
  * `struct` in Rust

* For the sentinel value representing absence:
  * In Go, define a struct called `Option` with a boolean field `some` indicating whether a value is present and a second field holding the value; use an instance with `some = false` to signal absence.
  * In Julia, use `nothing`.
  * In OCaml, use the `None` constructor of the `option` type.
  * In Rust, use the `None` variant of `Option`.

|      |                      |
|------|----------------------|
|Go    |[multiple return values](https://www.tutorialspoint.com/go/go_functions.htm)|
|Julia |[nothing](https://syl1.gitbook.io/julia-language-a-concise-tutorial/language-core/data-types#missing-nothing-and-nan)|
|OCaml |[option](https://ocaml.org/docs/tour-of-ocaml#pattern-matching-contd)|
|Rust  |[Option](https://www.tutorialspoint.com/rust/rust_quick_guide.htm)|

* This is a warm-up exercise intended to build familiarity with the syntax for parametric polymorphism in functions and data structures.
* In Julia and OCaml, type annotations can be omitted in many places; notice how verbosity varies across languages.

* Boilerplate source files `{go,jl,ml,rs}/basics.{go,jl,ml,rs}` containing test code are generated and shown below.
* Edit the source files by opening them in a text editor (e.g., VS Code) or by editing and executing the cells below.


