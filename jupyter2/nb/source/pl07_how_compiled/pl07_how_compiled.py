""" md
#* Programming Languages (7) --- How Programs are Compiled
"""
""" md w
Enter your name and student ID.
 * Name:
 * Student ID:
"""
""" md

# Objective

* Learn how programs are compiled into machine (assembly) code
* To this end, we compile simple functions into assembly code and observe the generated assembly code
"""

""" md

# How to generate assembly code

"""

""" md

## Go

- ordinary go compiler does not support emitting native assembly
- it instead emits something called "plan 9 assembly" ([details](https://go.dev/doc/asm)), which is a machine-independent, therefore portable, assembly
- to obtain the native assembly, you first `go build` a file to obtain an _object file_ --- the real binary machine code containing instructions --- and reverse it back to assembly (textual representation of instructions) using `go tool objdump`
- `go tool objdump` prints the plan 9 assembly; giving `-gnu` option prints the native assembly as well, which is our interest
- the following commands print the native assembly code of `src.go`:

```
go build -o src.o src.go
go tool objdump -gnu src.o
```

"""

""" md

## Julia

- Julia has <font color="blue">code_native</font> function in <font color="blue">InteractiveUtils</font> package, that prints assembly code of a function given particular concrete types for its input parameters
- e.g.,
```
f(x, y) = x + y + 1
import InteractiveUtils
InteractiveUtils.code_native(f, (Int64, Int64))
```
or
```
f(x :: Int64, y :: Int64) = x + y + 1
import InteractiveUtils
InteractiveUtils.code_native(f)
```
- `julia` command line options:
  - `-O3` to enable aggressive optimization
- Assuming `src.jl` contains above call(s) to `code_native`, the following command prints the assembly code of `src.jl`:

```
julia -O3 src.jl
```

"""

""" md

## OCaml

- `ocamlopt` is a "native compiler" that translates OCaml source into machine code (`ocamlc` compiles OCaml to bytecode)
  - `-S` to emit assembly code
  - `-O3` to enable aggressive optimization
- the following command prints the assembly code of for `src.ml`:

```
ocamlopt -O3 -S src.ml
```


"""

""" md

## Rust

- `rustc` is a compiler for Rust
  - `--emit asm` to generate assembly code
  - `--crate-type lib` to say this is for a library, not an executable, which does not have the `main` function
  - `-C opt-level=3` to enable aggressive optimization
- the following command prints the assembly code of for `src.rs`:

```
rustc -C opt-level=3 --emit asm --crate-type lib src.rs -o src.s
```

"""

""" md

# AI Tutor

* Run the cell below to enable it.
* For the AI use policy in this course, see the [home page](https://taura.github.io/programming-languages/index.html#ai_policy).
"""

""" code w kernel=python """
import heytutor
""" """

""" md

# Show Status

"""
""" code """
TOPICS = ["how_compiled"]
heytutor.show_status(topics=TOPICS)
""" """

""" md

# Generate a Problem

* The `gen_problem` function generates a problem based on your preference.
* Uncomment one of the options below and run the cell.
* The goal is to solve the final problem, `generic_optimize`, in this topic. You may want to use `prev_prob` to step backward from the last problem, or `next_prob` to step forward from the first.
"""

""" code w """
PREFERENCE = "next_prob"        # start from the first problem and move forward
#PREFERENCE = "prev_prob"       # start from the last problem and move backward if too difficult
#PREFERENCE = "next_topic"
#PREFERENCE = "prev_topic"
#PREFERENCE = "last_topic"
#PREFERENCE = "first_topic"
#PREFERENCE = "random"
#PREFERENCE = "match:how_compiled/loop"
heytutor.gen_problem(topics=TOPICS, pref=PREFERENCE)
""" """

""" md

# Goal

* Your goal in this notebook is to solve the following mandatory problems:
   * loop
   * funcall
   * memory_allocation
* Other problems are optional, but you are encouraged to solve all of them from the beginning to the end, especially if you are new to assembly code. You can use `prev_prob` and `next_prob` to step backward and forward, respectively.

"""

