# <font color="green">Using libraries</font>

* After mastering the basics of a programming language, writing a program is as much about using _libraries_ as about writing your own code
* Being confident in finding an appropriate library on the web and correctly using it in your program is an important step toward mastering a language
* Using a library generally entails some or all of the steps below:
  * Searching for a library you want
  * Installing it if necessary (e.g., Python's `pip` command or from GitHub)
  * Telling the compiler/interpreter where the library is installed, if it is not in a default location --- this is generally done by setting an environment variable (Python's `PYTHONPATH`), passing a command-line option, or setting a variable in the interactive environment (Python's `sys.path`)
  * Writing a statement or command to import it in your program, so that you can refer to its functions, variables, etc. (Python's `import` statement)
* Some libraries are _builtin_, meaning they require none of the above steps (e.g., Python's `open` function)
* Some libraries are not builtin but _standard_, meaning they are installed with the language itself; you do not have to install them, but you do need to import them (e.g., Python's `re` module)
* Others are _external_, meaning they must be installed
* Some languages (OCaml, Go, and Rust) have a build system that automatically downloads and installs external libraries
* Depending on which category a library falls into, the required steps and the way you refer to its names may differ, as summarized below

# Go

## Builtin libraries

* Go's builtin names are documented in the [`builtin` package](https://pkg.go.dev/builtin). They are available automatically in any program
* If a name you want to use (e.g., a function, variable, or type) is in the builtin package, you can use it by its name alone
* For example, there is a function `func println(args ...Type)` in that page, which means it is in the builtin package, so you can simply write
```println(10)```
in any program

## Standard libraries

* Go's [Standard library](https://pkg.go.dev/std) consists of packages installed with the Go system
* To use a name from a standard library:
  * Put <font color="blue">import "_package-name_"</font> (notice the double quotes) near the top of the source file, and
  * Use <font color="blue">_package-name_._name_</font> to refer to it
* Example:
  * Say you want to use the `Abs` function in the [math](https://pkg.go.dev/math) package
  * Put
```
import "math"
```
near the top of the file and write
```
math.Abs(-3)
```

## External libraries

* See [Managing dependencies](https://go.dev/doc/modules/managing-dependencies) for general concepts
* Search [pkg.go.dev](https://pkg.go.dev/) for a library you want
* Once you find the package page, locate the repository name (shown on the right side of the page) and put
<font color="blue">import "_repository-name_"</font>
in your source file
* `go build` does the rest, from downloading the library to compiling and linking it
* This scheme also works for packages not listed on [pkg.go.dev](https://pkg.go.dev/), as long as they are hosted on a public repository
* For example, if you search [pkg.go.dev](https://pkg.go.dev/) for `xmldom`, you will find the repository `github.com/subchen/go-xmldom` listed under the Repository section on the right of the [go-xmldom](https://pkg.go.dev/github.com/subchen/go-xmldom) page
* Import it like this (note: the package name is `xmldom`, derived from the directory name):
```
package main
import "github.com/subchen/go-xmldom"
func main() {{
        xmldom.ParseXML("<a>123</a>")
        println("hello world")
}}
```
* Then fetch it with:
```
go get github.com/subchen/go-xmldom
```
and `go build` will compile and link it with your program

# Libraries in Julia

## Builtin libraries

* Julia's builtin names live in the `Core` and `Base` modules. See the `Base` tab on the [Julia documentation page](https://docs.julialang.org/en/v1/) to browse available names. They are available automatically in any program
* If you find <font color="blue">Base._name_</font> in that page, you can use it by just <font color="blue">_name_</font> in your program

## Standard libraries

* Julia's [Standard Library](https://docs.julialang.org/en/v1/) consists of modules installed with the Julia system
* To use a name _name_ from a standard library module, either:
  * Write <font color="blue">import _module-name_</font> near the top of your source file and refer to the name as <font color="blue">_module-name_._name_</font>, or
  * Write <font color="blue">using _module-name_</font> near the top of your source file and refer to the name as just <font color="blue">_name_</font> --- this brings all _exported_ names of the module into scope directly (similar to `from `_module-name_` import *` in Python)
* Example:
  * Say you want to use the `DateTime` function in the [Dates](https://docs.julialang.org/en/v1/stdlib/Dates/) module. You can either:

1.
```
import Dates
```
and then write
```
Dates.DateTime(2022)
```
2. or
```
using Dates
```
and then write just
```
DateTime(2022)
```

## External libraries in Julia

* Search for packages on [JuliaHub](https://juliahub.com/ui/Packages) or [Julia Packages](https://juliapackages.com/)
* If you find a library you want, install it from the Julia interactive environment:
```
$ julia
julia> import Pkg
julia> Pkg.add("name")
```
* Example: say you want to use the [LightXML](https://juliahub.com/ui/Packages/LightXML/a89nj/0.9.0) package
* Install it:
```
$ julia
julia> import Pkg
julia> Pkg.add("LightXML")
```
* In your program, write
```
import LightXML
```
or
```
using LightXML
```
* With the former, you access functions as `LightXML.parse_file`, `LightXML.root`, etc.; with the latter, exported names such as `parse_file` and `root` are accessible directly

# Libraries in OCaml

## Builtin libraries

* Builtin functions, types, etc. are in the `Stdlib` module. Names listed in the [Stdlib documentation](https://v2.ocaml.org/api/Stdlib.html) are available automatically in any program
* Example: your program can use the `sin` function simply by writing `sin`, as it is in `Stdlib`

## Standard libraries

* [OCaml's standard libraries](https://v2.ocaml.org/api/) are modules installed with the OCaml system
* Your program does not need to do anything special to use them --- they are found automatically by `dune`
  * <font color="blue">_module-name_._name_</font> refers to <font color="blue">_name_</font> in module <font color="blue">_module-name_</font>
  * Alternatively, add <font color="blue">`open` _module-name_</font> near the top of your source file; then <font color="blue">_name_</font> alone refers to _name_ in that module
* Example:
  * Say you want to use the variable `argv` in [Module Sys](https://v2.ocaml.org/api/Sys.html)
  * You can use it either by:

1.
```
Sys.argv
```
2. or by putting
```
open Sys
```
near the top of your program and then writing just
```
argv
```

## External libraries

* Search for a library you want on [opam](https://opam.ocaml.org/packages/)
* If found, install it with <font color="blue">opam install _package-name_</font>
* Once installed, use it via `dune` by adding it to the `libraries` field in your `dune` file
* Example:
  * Say you want to use the `parse` function in the [markup](https://opam.ocaml.org/packages/markup/) package
  * Find its [README on GitHub](https://github.com/aantron/markup.ml) and [documentation](http://aantron.github.io/markup.ml/)
  * Assuming your project is named `foo`:
    1. Add `markup` to the `libraries` field in `foo/bin/dune`, i.e., change it from
```
(executable
 (name main)
 (libraries foo))
```
to
```
(executable
 (name main)
 (libraries foo markup))
```
    2. Call `parse` in your program as `Markup.parse`
    3. Install the library:
```
opam install markup
```
    4. Build with dune:
```
dune build
```

# Libraries in Rust

## Builtin libraries
* Rust's automatically available names are defined in the [std::prelude](https://doc.rust-lang.org/std/prelude/index.html) module. See [prelude::v1](https://doc.rust-lang.org/std/prelude/v1/index.html) for the specific names available in all Rust programs
* If you find a name such as `std::`_module_`::`_name_ listed there, you can use it by just _name_ in any program
* For example, `std::option::Option::None` is in the prelude, so you can simply write `None` in any program

## Standard libraries
* Rust's standard library, [Crate std](https://doc.rust-lang.org/std/), is the set of modules and macros installed with the Rust system
* Navigating to a module, you can find entities such as structs, traits, and functions
  * For example, [fs](https://doc.rust-lang.org/std/fs/index.html) is a module in `std` containing a struct [File](https://doc.rust-lang.org/std/fs/struct.File.html) and a function [read](https://doc.rust-lang.org/std/fs/fn.read.html)
* A module may contain submodules
  * For example, the [f64](https://doc.rust-lang.org/std/f64/index.html) module contains a submodule [consts](https://doc.rust-lang.org/std/f64/consts/index.html)
* You can refer to an entity by its fully qualified name, starting from `std`, through any intermediate module names, down to the entity name:
```
std::f64::consts::PI
```
(see [std::f64::consts::PI](https://doc.rust-lang.org/std/f64/consts/constant.PI.html))
* Or you can write
```
use std::f64::consts::PI;
```
near the top of your program and then refer to it as just `PI`
* You can also take a middle road; for example,
```
use std::f64;
```
or
```
use std::f64::consts;
```
lets you refer to `std::f64::consts::PI` as `f64::consts::PI` or `consts::PI`, respectively

## External libraries
* [crates.io](https://crates.io/) is the repository where you can search for libraries
* The same concepts from the standard library apply to external libraries --- an external library is simply a crate other than `std`
* Once you find a crate on [crates.io](https://crates.io/), add it to the `[dependencies]` section of `Cargo.toml`
* Example:
  * Say you want to use the `Element` struct in the [minidom](https://crates.io/crates/minidom) crate
  * Press the copy button on the right of the crates.io page to copy a string like
```
minidom = "0.18.0"
```
and paste it under `[dependencies]` in `Cargo.toml`
  * Alternatively, write
```
minidom = "*"
```
to always use the latest version
  * Consult the documentation by following [the link under "Documentation"](https://docs.rs/minidom/latest/minidom/)
  * In your source code, either:
    1. Add
```
use minidom;
```
and refer to `Element` as `minidom::Element`, or
    2. Add
```
use minidom::Element;
```
and refer to it as just `Element`
  * Build with:
```
cargo build
```
which downloads, compiles, and links the library automatically
  * Run with:
```
./target/debug/foo
```
or
```
cargo run
```

# <font color="green">Problem</font>

* Write a program that takes a filename of an XML file as the command-line argument, parses it into a DOM tree, and prints its _height_
* Use an appropriate XML library
  * Go: xmldom
  * Julia: LightXML
  * OCaml: xml-light
  * Rust: minidom
* In case you do not know XML, XML (Extensible Markup Language) is a text format for representing structured data as nested elements, each delimited by an opening and closing tag:
```
<mul>
  <plus>
    <num>3</num>
    <num>4</num>
  </plus>
  <num>5</num>
</mul>
```
This represents the arithmetic expression (3 + 4) $\times$ 5.
* You can easily imagine the above can be naturally represented as a tree, whose nodes have a label (`num`, `plus`, or `mul`)
* _Height_ of an XML element is defined recursively:
  * An element containing no child elements (a leaf) has height 1.
  * An element containing one or more child elements (an internal node) has height 1 + the maximum height among its children.
* In the example above, each `<num>` node has height 1, the `<plus>` node has height 2, and the `<mul>` node has height 3
