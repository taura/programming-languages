#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
//#import themes.university: *
//#import themes.aqua: *
//#import themes.dewdrop: *
//#import themes.simple: *
//#import themes.stargazer: *
//#import themes.default: *
//#import "@preview/numbly:0.1.0": numbly

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  config-info(
      title: [Parametric Polymorphism \ a.k.a. _Generic_ Functions and Types],
      author: [Kenjiro Taura],
      date: [],
  ),
)

#set text(font: ("Liberation Serif", "Noto Sans CJK JP"))
#set text(size: 28pt)
#set quote(block: true)
#let ao(x) = text(blue)[#x]
#let aka(x) = text(red)[#x]
#let small(x) = text(size: 20pt)[#x]

/* include image sequence xxx_L1.svg, xxx_L2.svg, ... */
#let images(prefix, rng, ..kwargs) = for (i, j) in rng.enumerate() [
  #only(i+1, image(prefix + "_L" + str(j) + ".svg", ..kwargs))
]

#show raw.where(block: true): it => text(size: 20pt, pad(left: 0.7em, it))
#show raw.where(block: false): it => text(rgb(127,127,127), size: 20pt, it)

#title-slide()

// #outline(depth: 1)

== Motivations
say want to write …
- a function that _sorts arrays of various types_ (e.g., ints, floats, strings, structs, …)
- a function that _extracts elements from a list satisfying_ $p(x)$
- _stacks, queues, trees, graphs, hashtables, etc._
- many _graph algorithms (breadth-first search, depth-first search, connected components, partitioning, etc.)_

... _*without duplicating code*_ for each element type

== Type-Parameterized Functions/Data

- what we need are functions or data structures that are _parameterized_ by component type(s)
- something like:
    - $alpha -> "int"$ (a function taking any type and returning int)
    - array of $alpha$ (an array of any type)

== What is an issue? --- a trivial example
write a generic function  
$f(a) = a[0]$  
in your language (an element of an array) that works for any element type

Questions:
- do you have to specify the type of $a$?
- if so, how can you say _*$a$ must be an array but whose element can be any type*_
- if not, what does its type become?
    - take _anything_, array of _anything_, ...?
    - _*does it type-check statically*_?

== Type expressions

- things are conceptually straightforward
- but _*spelling out types*_ needs a practice (for languages that require type annotations)
- master the syntax of _*type expressions, parameterized types/functions, and instantiation thereof*_

== Type expressions for functions
ex. a type of _*functions taking an integer and returning a float*_

#align(center,[
#table(columns: (auto,auto,auto), align: left, inset: 10pt,
[Go],    [```go func (int64) float64```], [],
[Julia], [```julia Function```],          [($ast$), ($dagger$)],
[OCaml], [```ocaml int -> float```],      [($dagger$)],
[Rust],  [```rust fn (i64) -> f64```],    []
)])

- ($ast$) cannot specify input/output types
- ($dagger$) you normally don't write it

== Type expressions for array-like data
ex. (one-dimensional) array (or likes) of 64-bit floats

#text(24pt)[
#align(center, [
    #table(columns: (0.1fr,0.3fr,0.2fr), align: left, inset: 10pt,
        [Go],    [fixed-size ($n$-element) array \ slice], [```go [n]float64``` ($ast$) \ ```go []float64```],
[Julia], [],                  [```julia Vector{Float64}```],
[OCaml], [],                  [```ocaml float array```],
        [Rust],  [fixed-size ($n$-element) array \ vector \ slice], [```rust [f64; n]``` ($ast$) \ ```rust Vec<f64>``` \ ```rust [f64]```],
)])
]
- ($ast$) `n` has to be a compile-time constant

== Defining parameterized types
ex. `Node` (or `Tree`) of any type

#align(center, [
#table(columns: (auto, auto), align: left, inset: 10pt,
[Go],    [```go type Node[T any] struct { ... }```],
[Julia], [```julia struct Node{T} ... end```],
[OCaml], [```ocaml type 'a tree = ...``` \ ```ocaml class ['a] node ... = object ... end```],
[Rust],  [```rust enum Tree<T> { ... }``` \ ```rust struct Node<T> { ... }```]
)])

#pagebreak()

and a version parameterized by _any subtype of S_

#align(center, [
#table(columns: (auto, auto), align: left, inset: 10pt,
[Go],    [```go type Node[T S] struct { ... }```],
[Julia], [```julia struct Node{T<:S} ... end```],
[OCaml], [not available],
[Rust],  [```rust enum Tree<T : S> { ... }``` \ ```rust struct Node<T : S> { ... }```]
)])

== Instantiating parameterized types
ex. `Node` of 64-bit integers

#align(center, [
#table(columns: (auto, auto, auto), align: left, inset: 10pt,
[Go],    [```go Node[int64]```],    [],
[Julia], [```julia Node{Int64}```], [],
[OCaml], [```ocaml int node```],    [],
[Rust],  [```rust Node<i64>``` or ```rust Node::<i64>```], [($ast$)]
)])

- ($ast$) `::` is necessary to disambiguate the symbol `<`
- $approx$ `::` is unnecessary where only type expressions are expected and necessary when ordinary expressions are expected

== Defining parameterized functions
ex. a function `dfs`, which can work for node of _*any type*_

#align(center, [
#table(columns: (auto, auto, auto), align: left, inset: 10pt,
[Go],    [```go func dfs[T any](n Node[T]) { ... }```],            [],
[Julia], [```julia function dfs(n : Node{T}) where T ... end```], [],
[OCaml], [```ocaml let dfs (n : 'a tree)  = ...```
        \ ```ocaml let dfs n = ...```],                             [($ast$) \ \ ],
[Rust],  [```rust fn dfs<T>(n : Tree<T>) { ... }```],            [],
)])

- ($ast$) : normally not necessary

#pagebreak()

and a version that can work for _*any subtype of S*_

#align(center, [
#table(columns: (auto, auto), align: left, inset: 10pt,
[Go],    [```go func dfs[T S](n Node[T]) { ... }```],
[Julia], [```julia function dfs(n : Node{T}) where {T<:S} ... end```],
[OCaml], [not available],
[Rust],  [```rust fn dfs<T : S>(n : Tree<T>) { ... }```],
)])

== Instantiating parameterized functions

#align(center, [
#table(columns: (auto, auto, auto), align: left, inset: 10pt,
[Go],    [```go bfs[int64](...)```],      [],
[Julia], [```julia function bfs(...)```], [no specific syntax],
[OCaml], [```ocaml bfs ...``` ],          [no specific syntax],
[Rust],  [```rust bfs::<i64>(...)```],    [],
)])

== Type inference of compound expressions

- _type inference_ generally refers to any algorithm that determines the static type of an expression without programmer's annotation
- virtually all languages infer types of compound expressions from their components
    - e.g., $e_0$ and $e_1$ are `int` $=>$ $e_0 + e_1$ is `int`

== Type inference of local variables

- many languages automatically infer types of local variables
    - Go : type of a local variable introduced by $x$ `:=` $e$ is inferred from $e$
    - Rust : type of a local variable introduced by `let `$x$ ` = ` $e$ is inferred from $e$
    - C++ has a similar mechanism (`auto`)
- _they all infer type of a compound expression from the types of its sub-expressions_
- for it to work, _type of function parameters must be given_

== Type reconstruction (e.g., type inference in OCaml)

- OCaml's type inference is remarkable in that it infers types of function parameters from function body
- e.g.,
    - `let f x y = x + y` #h(0.3em) : #h(0.3em) $"int" -> "int" -> "int"$
    - `let f x = x` #h(0.3em) : #h(0.3em) $alpha -> alpha$
    - `let f a = a.[0]` #h(0.3em) : #h(0.3em) $alpha "array" -> alpha$
    - `let f a = a.[0] + 1` #h(0.3em) : #h(0.3em) $"int" "array" -> "int"$
    - `let f o = o#area < 1.0` #h(0.3em) : #h(0.3em) $"< area : float; ..>" -> "bool"$

== How type reconstruction works

- intuitively, it works by collecting _constraints_ and solving them
    - `x + y` $->$ `x : int`, `y : int` (assumption: `+ : int -> int`)
    - `a.[i]` $->$ `a : 'a array`
    - `s#area` $->$ `s : < area : 'a; ... >`
- e.g., from `a.[i] + 1`
    - `a : 'a array`
    - `a.[i] : int`  (because of `+`)
    - $=>$ `'a = int`

== Remarks about OCaml

- thanks to type inference, you can omit most type annotations in OCaml, but it still does static type checking
    - not like Python or Julia
- it is indeed _type safe_
- to reason about what kind of programs are statically type-checked, you have to know possible types and their syntax (e.g., to understand error messages)
- it is possible, and indeed useful, to give type annotations for documentation and diagnosing type errors
