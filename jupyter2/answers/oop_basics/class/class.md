# <font color="green">Defining a Class</font>

- A *class* is a way to define a composite type together with functions associated with it, called *methods*.
- Different languages use different keywords for this mechanism:
  - `class` : Python, Java, and OCaml
  - `struct` : Go, Julia, and Rust
  - `struct` or `class` : C++
- Regardless of the keyword, the construct generally specifies what fields and methods values of that type have.

## Docs

Relevant constructs and documentation sections.

**Classes**

|       |        |                                                                                     |
| :---- | :----- | :---------------------------------------------------------------------------------- |
| Go    | struct | [Data](https://go.dev/doc/effective_go#data)                                        |
| Julia | struct | [Composite Types](https://docs.julialang.org/en/v1/manual/types/#Composite-Types)  |
| OCaml | class  | [Objects in OCaml](https://ocaml.org/manual/objectexamples.html)                   |
| Rust  | struct | [Using Structs to Structure Related Data](https://doc.rust-lang.org/book/ch05-00-structs.html) |

**Methods**

|       |          |                                                                                                          |
| :---- | :------- | :------------------------------------------------------------------------------------------------------- |
| Go    | func     | [Methods](https://go.dev/doc/effective_go#methods)                                                       |
| Julia | function | [Methods](https://docs.julialang.org/en/v1/manual/methods/#Methods)                                      |
| OCaml | method   | [Objects in OCaml](https://ocaml.org/manual/objectexamples.html)                                         |
| Rust  | impl     | [Method Syntax](https://doc.rust-lang.org/book/ch05-03-method-syntax.html?highlight=impl#method-syntax)  |

## <font color="green">Problem</font>

- Define a class (or struct) named `free_ellipse` (or `FreeEllipse`, depending on your language's naming convention --- this remark will not be repeated for subsequent names) that represents an ellipse. The word *free* indicates that its position is not fixed.
- Define a method `area` on it that returns the ellipse's area.
- Define a function `mk_free_ellipse` that takes two floating-point numbers $a$ and $b$ and returns an ellipse with horizontal radius $a$ and vertical radius $b$. For simplicity, assume the radii are aligned with the x- and y-axes.
  - **Note 1:** Defining the function just to make an instance of `free_ellipse` class may feel somewhat redundant, since many languages automatically generate a constructor when a class or struct is defined. The separate function is introduced primarily to establish a clear interface between your code and the test code, and to give you flexibility.
  - **Note 2:** In OCaml, a class is not strictly necessary to implement `mk_free_ellipse`. That said, introducing a class makes it easier to reuse the implementation in later problems.
- Define a function `smaller` that takes two ellipses $e_0$ and $e_1$ and returns 0 if $e_0$'s area is less than or equal to $e_1$'s area, and 1 otherwise.
- **Looking ahead:** In the next problem you will define a class representing rectangles. In OCaml you could unify both shapes under a single type using variants; in Rust, you could use `enum`. In this exercise, however, the focus is on defining classes with the same or compatible interfaces, and on understanding the benefits of doing so.
- Boilerplate source files `{go,jl,ml,rs}/{base}.{go,jl,ml,rs}` containing the test code are generated and shown below.
- Edit the source files either by opening them in a text editor (e.g., VS Code) or by editing and executing the cells below.

