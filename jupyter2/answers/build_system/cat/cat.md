# <font color="green">Build system</font>

* A _build system_ is a program that helps you develop programs that use external libraries and/or consist of multiple files
* Go, OCaml, and Rust have their own build systems: go, dune, and cargo, respectively; Julia does not

# Go: go is the build system

* Document: [How to Write Go Code](https://go.dev/doc/code)
* Steps to create a program (_module_ in Go terminology), `foo`
* Make a module
  * `mkdir -p foo`
  * `cd foo`
  * `go mod init foo`
* Create file(s) (e.g., `foo.go`) in directory `foo`
* Build it (in `foo` directory)
  * `go build`
* Run it (in `foo` directory)
  * `./foo` or
  * `go run`

# Julia: no particular build system

* Julia has no build system, as it does not require a separate compilation step to produce an executable
* Source files are always just-in-time compiled and run immediately

# OCaml: dune is the build system

* [dune](https://dune.build/) is the de facto build system for OCaml
* [Document](https://dune.readthedocs.io/en/stable/), including the [Quickstart](https://dune.readthedocs.io/en/stable/quick-start.html) section
* Steps to create a program (_project_ in OCaml/Dune terminology), write a source file, and build it (see [Initializing a Project](https://dune.readthedocs.io/en/stable/usage.html#initializing-a-project) for more)
* Make a project
  * `dune init proj foo`
* Write source code
  * `foo/bin/main.ml` is the main source file you should edit
* Build it (in `foo` directory)
  * `dune build`
* Run it (in `foo` directory)
  * `./_build/default/bin/main.exe`
  * or `dune exec foo`

# Rust: cargo is the build system
* [cargo](https://doc.rust-lang.org/book/ch01-03-hello-cargo.html) is the build system for Rust
* [Document](https://doc.rust-lang.org/book/ch01-03-hello-cargo.html)
* Steps to create a program (_package_ in Rust terminology), `foo`
* Make a package
  * `cargo new foo`
* Edit the source
  * `foo/src/main.rs` is the source file you should edit
* Build the executable
  * `cargo build` for a debug build (no optimization)
  * `cargo build --release` for a release build (with optimization)
* Run it
  * `./target/debug/foo` for the debug build,
  * `./target/release/foo` for the release build, or
  * `cargo run`

# <font color="green">Problem</font>

* Make a program named `cat`, using your build system if one exists
  * For Julia, just create a directory `cat` and make `cat/cat.jl` there
* It should take a filename as a command-line argument and print its contents to standard output
* There is no boilerplate code for this problem; master the steps to create a project, write source code, and build it
