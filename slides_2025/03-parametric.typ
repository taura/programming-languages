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
    title: [Generic Functions and Types or \
    Parametric Polymorphism],
    author: [Kenjiro Taura],
    date: [2024/05/09],
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

== Motivation
say want to write …
- a function that _*sorts arrays of various types*_ (e.g., ints, floats, strings, structs, …)
- a function that _*extracts elements from a list satisfying*_ $p(x)$
- _*stacks, queues, trees, graphs, hashtables, etc.*_
- many _*graph algorithms (breadth-first search, depth-first search, connected components, partitioning, etc.)*_
- ... _*without duplicating code*_ for each element type

== A trivial example (generic function)
write a generic function  
$f(a) = a[0]$  
in your language (an element of an array) that works for any element type

Questions:
- do you have to specify the type of $a$?
- if so, how can you say _*$a$ must be an array but whose element can be any type*_
- if not, can it automatically apply to any array?
  - _*does it type-check statically*_ (i.e., what if you pass something not an array)?

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

#align(center, [
#table(columns: (auto,auto,auto), align: left, inset: 10pt,
[Go],    [fixed-size ($n$-element) array \ slice], [```go [n]float64``` \ ```go []float64```],
[Julia], [],                  [```julia Vector{Float64}```],
[OCaml], [],                  [```ocaml float array```],
[Rust],  [fixed-size ($n$-element) array \ vector \ slice], [```rust [f64; n]``` \ ```rust Vec<f64>``` \ ```rust [f64]```],
)])

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


