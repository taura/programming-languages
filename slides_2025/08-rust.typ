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
      title: [Rust Memory Management],
      author: [Kenjiro Taura],
      date: [2026/06/22],
  ),
)

#set text(font: ("Liberation Serif", "Noto Sans CJK JP"))
#set text(size: 24pt)
#set quote(block: true)
#let ao(x) = text(fill: blue, x)
#let aka(x) = text(fill: red, x)
#let ore(x) = text(fill: orange, x)
#let brown = rgb("#A52A2A")
#let mura(x) = text(fill: brown, x)
#let mido(x) = text(fill: green, x)
#let small(x) = text(size: 20pt)[#x]
#let blink(x, y) = link(x, text(blue, y))
#let comm(x) = text(font: "Liberation Serif", style: "italic", "// " + x)
#let tt(x, ..kwargs) = text(font: "Liberation Mono", ..kwargs, x)
#let hh = h(1em)

#let commentout(x) = ""

#let cimg(x, ..opts) = align(center, image(x, ..opts))

/* include image sequence xxx_L1.svg, xxx_L2.svg, ... */
#let images(prefix, rng, ..kwargs) = for (i, j) in rng.enumerate() [
  #only(i+1, image(prefix + "_L" + str(j) + ".svg", ..kwargs))
]

//#show raw.where(block: true):  x => text(size: 16pt, pad(left: 0.7em, x))
//#show raw.where(block: false): x => text(rgb(127,127,127), size: 20pt, x)

//#show raw.where(block: true):  x => text(size: 20pt, pad(left: 0.7em, x))
//#show raw.where(block: false): x => text(rgb(127,127,127), size: 20pt, x)

#title-slide()

#outline(depth: 1)

= Introduction

== Rust's basic idea to memory management
- Rust maintains that, for any live object, 
  + there is _one and only one pointer that "owns" it #mura[(the owning pointer)]_ 
  + there are any number of non-owning pointers to it #ao[_(borrowing pointers)_]
  + _borrowing pointers cannot be dereferenced after the owning pointer goes away_
- #ao[$=>$ _it can safely reclaim the data when the owning pointer goes away_]

#grid(columns: 2, gutter: 1em, align: top,
[
#align(center)[
_"#mura[single-ownership] rule"_
#image("svg/L/one_owner_multiple_borrowers_L1.svg", width: 60%)
]
],
[
#tt(size: 20pt)[
{ \
#hh let a = S{x: ..., y: ...}; \
#hh ... \
} #comm[what `a` points to will be gone here]
]
])


== The rules are enforced statically

- Rust enforces the rules (or, detect violations thereof)
  - #ao[_statically_], not #aka[_dynamically_]
  - #ao[_compile-time_], not at #aka[_runtime_]
  - #ao[_before_] execution, not #aka[_during_] execution

#align(center)[
  #text(28pt)[_"borrow checker"_]
]

== Escaping from the single ownership model

- there are actually some ways to get around the rules

1. #ore[reference counting pointers] (≈ multiple owning pointers)
   - counts the number of owners _at runtime_, and reclaim the data when all these pointers are gone
2. #ore[unsafe/raw pointers] (≈ totally up to you)

they are not specific to Rust, and we'll not cover them below

= Rust Basics

== Pointer-like data types in Rust

given a type $T$ (`i32`, struct, enum, …), below are  
types representing "references (pointers) to $T$" // #footnote[we use pointers and references interchangeably]

1. #mura[$T$] : #mura[owning] pointer to $T$
2. #mura[`Box<`$T$`>`] (pronounced "_box $T$_") : #mura[owning] pointer to $T$
3. #ao[`&`$T$] (pronounced "_ref $T$_") : #ao[borrowing pointer] to $T$
4. #ore[`Rc<`$T$`>`] and #ore[`Arc<`$T$`>`] : shared (reference-counting) owning pointer to $T$
5. #ore[`*`$T$] : unsafe pointer to $T$

#grid(columns: 2, gutter: 1em, align: top,
[_following discussions are focused on_ #mura[$T$], #mura[`Box<`$T$`>`] _and_ #ao[`&`$T$]],
[
#align(center)[
  #image("svg/L/one_owner_multiple_borrowers_L2.svg", width: 70%)
]
])

== Pointer-making expressions

given an expression $e$ of type $T$, below are expressions that  
make pointers to the value of $e$ (besides $e$ itself)

- #mura[`Box::new(`$e$`)`] (of type #mura[`Box<`$T$`>`]) : an owning pointer  
- #ao[`&`$e$] (of type #ao[`&`$T$]) : a borrowing pointer

== An example
#tt(size: 20pt)[
{\
#hh let #mura[a]: S      = S{x: ...}; #h(5.5em) #comm[allocate memory for S] \
#h(18.5em)                                            #comm[and make an owning pointer to it] \
#hh let #mura[b]: S      = #mura[`a`]; #h(10em) #comm[an owning pointer] \
#hh let #mura[c]: Box`<`S`>` = #mura[`Box::<S>::new(a)`]; #comm[an owning pointer] \
#hh let #ao[d]: &S     = #ao[`&a`]; #h(9em)       #comm[a borrowing pointer] \
}
]

- note: type of variables can be omitted (spelled out for clarity)  
- note: the above program violates several rules so it does not compile

= Owning Pointers

== Assignments of owning pointers

- to maintain the "single-owner" rule, an assignment of owning pointers in Rust #aka[_does not copy, but moves it_] out of the righthand side, disallowing further use of it

#tt(size: 20pt)[
#hh b = a; #comm[a cannot be used below]
]

#grid(columns: (1em, auto, auto), gutter: 1em, align: top,
[],
[
#tt(size: 16pt)[
fn foo() { \
#hh let a = S{x: ..., y: ...}; \
#hh ... a.x ...; #comm[OK, as expected] \
#hh ... a.y ...; #comm[OK, as expected] \
#uncover("2-")[
#hh #comm[the reference moves out from a] \
#hh let b = a; \
#hh a.x; #comm[NG, the value has moved out] \
#hh b.x; #comm[OK] \
]
}
]
],
[
#images("svg/L/move_assignment", range(1, 3), width: 50%)
])

== Argument-passing also moves the reference

- passing a value to a function also moves the reference out of the source

#grid(columns: (1em, 60fr, 30fr), gutter: 1em, align: top,
[],
[
#tt(size: 20pt)[
fn foo() { \
#hh let a = S{x: ..., y: ...}; \
#hh ... a.x ...; #comm[OK, as expected] \
#hh ... a.y ...; #comm[OK, as expected] \
#uncover("2-")[
#hh #comm[moves the reference out of a] \
#hh f(a); \
#hh a.x; #comm[NG, the reference has moved] \
]
}
]
],
[
#images("svg/L/move_arg_passing", range(1, 3), width: 100%)
])

== Exceptions to "assignment moves the reference"
- you may notice the moving assignment contradicts what you have seen
#tt(size: 20pt)[
#hh b = a; #comm[a cannot be used after this]
]

- if it applies everywhere, does the following program violate it?  

#tt(size: 20pt)[
fn foo() -> f64 { \
#hh let a = 123.456; \
#hh let b = a; #comm[does the reference to 123.456 move out from a!?] \
#hh  a + 0.789 #h(1em) #comm[if so, is this invalid!?] \
}
]

- answer: no, it does #ao[_not_] apply to primitive types like `i32`, `f64`, etc.  
- more generally, it does not apply to data types that implement #ao[`Copy`] trait

== `Copy` trait

- define your struct with #ao[`#[derive(Copy, Clone)]`] like

#tt(size: 20pt)[
\#[derive(Copy, Clone)] \
struct S { ... }
]

- $=>$ assignment or argument-passing of `S` _copies_ the righthand side

#grid(columns: (1em, auto, auto), gutter: 1em, align: top,
[],
[#tt(size: 16pt)[
fn foo() { \
#hh let a = S{x: ..., y: ...}; \
#hh a.x; #comm[OK, as expected] \
#hh a.y; #comm[OK, as expected] \
#uncover("2-")[
#hh #comm[the value is copied] \
#hh #mura[let b = a;] \
#hh #ao[a.x;] #comm[OK] \
#hh #ao[b.x;] #comm[OK, too] \
]
}
]],
[#images("svg/L/move_assignment", (1,3), width: 30%)
- note: copy types trivially maintain the single-owner rule]
)

= `Box<`$T$`>` type

== `Box<`$T$`>` makes an owning pointer

- making a pointer by #mura[`Box::new(`$v$`)`] moves the reference out of $v$, too, and #mura[`Box::new(`$v$`)`] becomes the owning pointer

#grid(columns: (1em, auto, auto), gutter: 1em, align: top,
[],
[#tt(size: 16pt)[
fn foo() { \
#hh let a = S{x: ..., y: ...}; \
#hh a.x; #comm[OK, as expected] \
#hh a.y; #comm[OK, as expected] \
#uncover("2-")[
#hh #comm[OK, now `b` is the owning pointer] \
#hh #mura[let b = Box::new(a)] \
#hh #aka[a.x;] #comm[NG, the value has moved out] \
#hh #ao[(\*b).x;] #comm[OK] \
#hh #ao[b.x;] #comm[OK. abbreviation of (\*b).x] \
]
}
]],
[#images("svg/L/move_assignment", range(1, 3), width: 60%)]
)

== Difference between $T$ and `Box<`$T$`>`?

- as you have seen, the effects of
#tt(size: 20pt)[
let b = #ao[a];
]

and

#tt(size: 20pt)[
let b = #mura[Box::new(a)];
]

look very similar (identical)

- as far as data lifetime is concerned, it is in fact safe to say they are
- Rust has distinction between them for
  + specifying data layout
  + allowing dynamic dispatch only for `Box<`$T$`>`
  + specifying where data are allocated (stack vs. heap)

== Data layout differences between $T$ and `Box<`$T$`>`

- `S` and `U` below have different data layouts
  - #tt(size: 20pt)[struct S { ..., p: #ao[$T$], }] "embeds" a $T$ into `S`
  - #tt(size: 20pt)[struct U { ..., p: #mura[Box<$T$>], }] has `p` point to a separately allocated $T$

#align(center)[
#grid(columns: 2, 
[#image("svg/L/t_vs_boxt_L1.svg", width: 50%)],
[#image("svg/L/t_vs_boxt_L2.svg", width: 50%)]
)]

#pagebreak()

- in particular, `Box<`$T$`>` is essential to define recursive data structures
  - #tt(size: 20pt)[struct S { ..., p: #ao[S], }] is not allowed, whereas
  - #tt(size: 20pt)[struct U { ..., p: #mura[`Box<U>`], }] is

- note: `U` above can never be constructed; a recursive data structure typically uses `enum` or `Option<Box<..>>`
  - #tt(size: 20pt)[struct U { ..., p: #mura[`Option<Box<U>>`], }]

== Data layout differences between $T$ and `Box<`$T$`>`

- the distinction is insignificant when discussing lifetimes

#align(center)[
#grid(columns: 2, 
[#image("svg/L/t_vs_boxt_L1.svg", width: 50%)],
[#image("svg/L/t_vs_boxt_L2.svg", width: 50%)]
)]

- in both cases, data of $T$ (yellow box) is gone exactly when the enclosing structure is gone
- another difference is that Rust allocates $T$ on stack and move it to heap when `Box<`$T$`>` is made
  - but again, it has nothing to do with lifetime (unlike C/C++)

== Owning pointers and control flows

- Rust compiler determines, for each variable of owning pointer type ($T$ or `Box<`$T$`>`), at which point the variable can be _used_ (i.e., the value has not been moved out)
- it may be a _conservative_ estimate

#grid(columns: (1em, auto, auto), gutter: 1em, align: top,
[],
[
#tt(size: 16pt)[
fn foo() { \
#hh let a = S{x: ..., y: ...}; \
#hh if ... { \
#hh #hh let b = a; \
#hh } \
#hh ... a.x ... #comm[#aka[NG]] \
}
]
],
[
#tt(size: 16pt)[
fn foo() { \
#hh let a = S{x: ..., y: ...}; \
#hh for ... { \
#hh #hh let b = a; #comm[#aka[NG]] \
#hh } \
}
]
],
)

== A (huge) implication of the single-owner rule

#grid(columns: (70fr, 30fr), gutter: 1em, align: top,
[
- with only owning pointers ($T$ and `Box<`$T$`>`),
  - you can make #ao[_a tree_] of data,
  - but you #aka[_cannot make a general graph_] with joins or cycles, where _a node may be pointed to by multiple nodes_
- to make a graph whose nodes are $T$, use either
  - `&`$T$ to represent edges, or
  - `Vec<`$T$`>` to represent nodes and `Vec<(i32, i32)>` to represent edges
],
[
#image("svg/L/rust_can_make_tree_but_not_graph_L1.svg", width: 70%)
#image("svg/L/rust_can_make_tree_but_not_graph_L2.svg", width: 70%)
])

== The (huge) implication to memory management

#grid(columns: (65fr, 35fr), gutter: 1em, align: top,
[
- with only owning pointers (i.e., no borrowing pointers)
- #ao[_whenever an owning pointer is gone_] (e.g.,
  - a variable goes out of scope or
  - a variable or field is overwritten),
  
  #ao[_the entire tree rooted from the pointer can be safely reclaimed_]
],
[
#align(center)[
  #image("svg/L/rust_can_make_tree_but_not_graph_L1.svg", width: 70%)
]
#tt(size: 16pt)[
{ \
#hh let t = make_tree(...); \
#hh ... \
} ... #comm[`t` deallocated here]
]
])

- Rust exactly does that, with the additional guarantee that #ao[_borrowing pointers are never dereferenced after its owning pointer is gone_]

== Motto:

#align(left)[
#grid(columns: 3, row-gutter: 1em, column-gutter: 0.3em,
[_lifetime of data_],[=],[_lifetime of its owning pointer_],
[],[=],[_program points its owning pointer can be dereferenced_ ($dagger$)],
[],[$approx$],[_the block its owning pointer variable is defined_],
)]

#grid(columns: (2em, auto),
[],
[
#tt(size: 20pt)[
{ \
#hh let s = S{ ... }; #comm[or `Box::new(S{...})`] \
#hh ... \
#hh ... \
} ... #comm[referent of s reclaimed here]
]
])

- ($dagger$) : determined by control flows and assignments, to be precise

= Borrowing pointers (`&`$T$)

== Basics

- you can derive any number of borrowing pointers (`&`$T$) from $T$ or `Box<`$T$`>`
- the owning pointer remains valid after a borrowing pointer has been made

#tt(size: 20pt)[
#hh let a = S{x: .., y: ..}; \
#hh let b = &a; \
#hh ... a.x + b.x ... #comm[OK]
]

- the issue is how to prevent a program from #aka[_dereferencing borrowing pointers after its owning pointer is gone_]

== Borrowers rule in action

- a borrowing pointer cannot be dereferenced after its owning pointer is gone
#grid(columns: (1em, auto, auto), gutter: 1em, align: top,
[],
[
#tt(size: 16pt)[
fn foo() -> i32 { \
#hh let c: &S; #comm[a reference to S] \
#uncover("2-")[
#hh { #comm[an inner block] \
#hh #hh let b: &S; #comm[another reference] \
]
#uncover("3-")[
#hh #hh let a = S{x: ...}; #comm[allocate S] \
]
#uncover("4-")[
#hh #hh #comm[OK (both a and b live only until the end of the inner block)] \
#hh #hh #ao[b = &a;] \
]
#uncover("5-")[
#hh #hh #aka[c = b;] #comm[dangerous (c outlives a)] \
]
#uncover("2-")[
#hh }]#uncover("6-")[ #comm[`a` dies here, making `c` a dangling pointer] \
]
#uncover("6-")[
#hh #aka[c.x] #comm[NG (deref a dangling pointer)] \
]
}
]
],
[
#align(center)[
#images("svg/L/borrowers_assignment", range(1, 7), width: 100%)
]
])

== A _mutable_ borrowing reference (`&mut `$T$)

- data cannot be modified through ordinary borrowing references `&`$T$

#grid(columns: (1em,auto),
[],
[
#tt(size: 20pt)[
let a : S = S{x: 10, y: 20}; \
let b : &S = &a; \
b.x = 100; #comm[#aka[NG]]
]
])

- i.e., `&`$T$ is the type of #ao[_immutable_] references
- you can modify data only through #ao[_a mutable reference_] (`&mut `$T$)

#grid(columns: (1em,auto),
[],
[
#tt(size: 20pt)[
let #ao[mut] a : S = S{x: 10, y: 20}; \
let b : &#ao[mut] S = &#ao[mut] a; \
b.x = 100; #comm[#ao[OK]] \
]
])

- the difference is largely orthogonal to memory management

= Borrow-checking details

== A technical remark about the borrow-checking

- it's #ao[_not_] dangling pointers, _per se_, that are prevented, but their #aka[_dereferencing_]

- #ao[_the previous code compiles_] as long as `c` is not dereferenced

#grid(columns: (1em, auto),
[],
[
#tt(size: 16pt)[
fn foo() -> i32 { \
#hh let c: &S; #comm[a reference to S] \
#hh { #comm[an inner block] \
#hh #hh let b: &S; #comm[another reference] \
#hh #hh let a = S{x: ...}; #comm[allocate S] \
#hh #hh #comm[OK (both a and b live only until the end of the inner block)] \
#hh #hh #ao[b = &a;] \
#hh #hh #aka[c = b;] #comm[dangerous (c outlives a)] \
#hh } #comm[`a` dies here, making `c` a dangling pointer] \
#hh #comm[c.x don't deref c] \
}
]
])

== How borrow-checking works : lifetime

- _lifetime_ of data
  - $=$ program points where the data has not been deallocated
  - $=$ program points where the data's owning pointer is valid
- for each borrowing pointer, Rust compiler determines the _lifetime_ of data it points to #ao[_(referent lifetime)_] as its static type
- upon assignment $p = q$ between borrowing pointers, it demands
#align(center)[
referent lifetime of $p$ $subset$ referent lifetime of $q$ 
]

== How borrow-checking basically works

#grid(columns: 2, gutter: 1em, align: top,
[
#tt(size: 16pt)[
fn foo() -> i32 { \
#hh let c: &S; \
#hh { \
#hh #hh let b: &S; \
#hh #hh let a = S{x: ...}; #comm[lives until $alpha$] \
#uncover("2-")[
#hh #hh #box(stroke: black, inset: 0.2em)[
#ao[b = &a;] #comm[b's referent lifetime $subset$ a's $= alpha$ ] \
#ao[c = b;] #comm[c's referent lifetime $subset$ b's $= alpha$]
] ... $alpha$ \
]
#hh } \
#uncover("3-")[
#hh #aka[c.x] #comm[NG (deref outside c's referent lifetime = $alpha$)] \
]
}
]
],
[
+ the owning pointer `a`'s lifetime is the inner block; call it $alpha$ (#box(stroke: black, inset: 0.1em)[...])
+ let $beta$ and $gamma$ be referent lifetimes of `b` and `c`, respectively
#uncover("2-")[
+ due to the assignments,
  - #ao[`b = &a`] $=> beta subset alpha$ 
  - #ao[`c = b`] $=> gamma subset beta med (subset alpha)$
]
#uncover("3-")[
+ dereference #aka[`c.x`] must be $subset gamma med (subset alpha)$, which is not the case (i.e., #aka[invalid])
]
])

== Programming with borrowing references

- in more general cases, programs using borrowing references must help compilers track their referent lifetimes
- this must be done for functions called from unknown places, function calls to unknown functions and data structures
- to this end, the programmer sometimes must annotate #ao[_reference types with their referent lifetimes_]

== References in function calls

- how to check the validity of a functions call without knowing its body?
 #grid(columns: (55fr, 45fr), gutter: 1em, align: top,
[ 
 #tt(size: 16pt)[
{ \
#hh let r : &i32; \
#hh let #ao[a] = 123; \
#hh #box(stroke: blue, inset: 0.2em)[
    { \
    #hh let #mura[b] = 456; \
    #hh #box(stroke: brown, inset: 0.2em)[{ \
        #hh let #mido[c] = 789; \
        #hh #box(stroke: green, inset: 0.2em)[r = foo(&a, &b, &c);] ... #mido[$gamma$] \
        } ] ... #mura[$beta$] \
    } \
    #aka[\*r] \/\/ ($dagger$) ] ... #ao[$alpha$] \
}
]
],
[
- #aka[`*r`] should be safe if `f(p, q, r)` returns a reference whose referent lifetime contains ($dagger$); i.e., `p`
])

== References in data structures

- how to check the validity of dereferencing references obtained from a data structure

 #tt(size: 16pt)[
struct A { b : &B } \
struct B { c : &C } \
struct C { x : i32 } \
#hh ... \
#hh let c = C{x : 123}; \
#hh let b = B{c : &c}; \
#hh let mut a = A{b : &b}; \
#uncover("2-")[
#hh { \
#hh #hh let b2 = B{c : &c}; \
#hh #hh #box(stroke: black, inset: 0.2em)[a.b = &b2;] \
#hh } \
]
#hh a.b.c.x \/\/ OK? \
]

== References in function parameters

- how to check the validity of functions taking references or structures containing references, _without knowing all its callers_

 #tt(size: 16pt)[
fn bar(a : &mut &i32, b : &i32) { \
#hh \*a = b; \
} \
]

- what if references are in structures ...

 #tt(size: 16pt)[
fn baz(a : &mut A, b: &B) { \
#hh a.b = b \
}
]

/*
#commentout[
== References in function return values

problem: how to check the validity of:
+ functions returning references _without knowing its all callers_
 #tt(size: 16pt)[
fn return_ref(...) -> &P { \
#hh ... \
#hh let p: &P = ... \
#hh ... \
#hh #aka[`p`] #comm[OK?] \
}
]
+ function calls receiving references from function calls
#tt(size: 16pt)[
fn receive_ref() { \
#hh ... \
#hh let p: &P = return_ref(...); \
#hh ... \
#hh #aka[`p.x`] #comm[OK?] \
}
]
]
*/

== Reference type with a lifetime parameter

- to address these problems, Rust's borrowing reference types (#ao[`&`$T$] or #ao[`&mut `$T$]) carry #ao[_lifetime parameter representing their referent lifetimes_]
#uncover("2-")[
- syntax:
  - #ao[`&'`$a$ $T$] : reference to "$T$ whose lifetime is `'`$a$"
  - #ao[`&'`$a$ `mut `$T$] : ditto; except you can modify data through it
]  
#grid(columns: (70fr, 30fr), gutter: 1em, align: top,
[
#uncover("3-")[
- _every_ reference carries a lifetime parameter, though there are places you can omit them
- roughly, you must write them explicitly in function parameters, return types, and struct/enum fields; and can omit them for local variables
]
],
[
#align(center)[
  #images("svg/L/lifetime_parameter", (1, 2, 2), width: 100%)
]
])

== Attaching lifetime parameters

- rule: reference types that appear in function parameters, return types, and struct/enum fields must have explicit lifetime paramters


== Attaching lifetime parameters to functions

- therefore the following does not compile:
#tt(size: 20pt)[
fn foo(ra: &i32, rb: &i32, rc: &i32) -> &i32 { \
#hh ra \
}
]

with errors like:
#text(size: 16pt)[
```
|
| fn foo(ra: &i32, rb: &i32, rc: &i32) -> &i32 {
|            ----      ----      ----     ^ expected named lifetime parameter
|
= help: this function's return type contains a borrowed value, but the signature does not say whether it is borrowed from `ra`, `rb`, or `rc`
help: consider introducing a named lifetime parameter
|
| fn foo<'a>(ra: &'a i32, rb: &'a i32, rc: &'a i32) -> &'a i32 {
|       ++++      ++           ++           ++          ++
```
]

== Why do we need an annotation, _fundamentally_?

- without any annotation, how to know whether this is safe, #mura[_without knowing the body of `foo`?_]

#grid(columns: 2, gutter: 1em, align: top,
[
#tt(size: 16pt)[
{ \
#hh let r : &i32; \
#hh let a = 123; \
#hh { \
#hh #hh let b = 456; \
#hh #hh { \
#hh #hh #hh let c = 789; \
#hh #hh #hh r = foo(&a, &b, &c); \
#hh #hh } \
#hh } \
#hh \*r \
}
]
],
[
- essentially, the compiler complains "tell me what kind of referent lifetime the reference returned by `foo(&a, &b, &c)` has"
- it must be inferred without knowing the body of `foo`, only from its type

]
)

== Attaching lifetime parameters

- functions
 
 #tt(size: 20pt)[
fn f#ao[`<'a,'b,'c,...>`] ($p_0$ : $T_0$, $p_1$ : $T_1$, ...) -> $T_r$ { ... }
]

- structs/enums

 #tt(size: 20pt)[
struct A#ao[`<'a,'b,'c,...>`] { \
#hh $f_0$ : $T_0$, \
#hh $f_1$ : $T_1$, \
#hh ... \
}
]

- $T_0, T_1, ...$, and $T_r$ may use `'a`, `'b`, `'c`, ... as lifetime parameters  (e.g., `&'a i32`)

== One way to attach lifetime parameters to the example

#tt(size: 20pt)[
fn foo#ao[<`'`a>]\(ra: &#ao[`'`a] i32, rb: &#ao[`'`a] i32, rc: &#ao[`'`a] i32\) -> &#ao[`'`a] i32
]

#grid(columns: (auto, auto), gutter: 1em, align: top,
[
- effect: the return value is assumed to point to the shortest of the three
- why? generally, when Rust compiler finds `foo(x, y, z)`, it tries to determine `'a` so that `'a` $subset$ referent lifetimes of `x, y,` and `z`
- in this case,

`'a` $subset$ (life time of `a`) $inter$ (life time of `b`) $inter$ (life time of `c`) $=$ life time of `c`
- as a result, our program does not compile, even if `foo(&a,&b,&c)` in fact returns `&a`
],
[
#tt(size: 16pt)[
{ \
#hh let r: &i32; \
#hh let a = 123; \
#hh { \
#hh #hh let b = 456; \
#hh #hh { \
#hh #hh #hh let c = 789; \
#hh #hh #hh #ao[r = foo(&a, &b, &c);] \
#hh #hh #hh #comm[`'a` $<- alpha inter beta inter gamma = gamma$] \
#hh #hh #hh #comm[and `r`'s type becomes `&`$gamma$` i32`] \
#hh #hh } #comm[c's lifetime (= $gamma$) ends here] \
#hh } #comm[b's lifetime (= $beta$) ends here] \
#hh #aka[\*r] #comm[NG, as we are outside $gamma$] \
} #comm[a's lifetime (= $alpha$) ends here] \
]
])

== An annotation that works

#tt(size: 20pt)[
fn foo<#ao[`'a`],#aka[`'b`],#mido[`'c`]>(ra: &#ao[`'a`] i32, rb: &#aka[`'b`] i32, rc: &#mido[`'c`] i32)->&#ao[`'a`] i32
]
#grid(columns: 2, gutter: 1em, align: top,
[
- signifies that the return value points to data whose lifetime is `ra`'s referent lifetime (and has nothing to do with `rb`'s or `rc`'s)
- for `foo(x, y, z)`, Rust compiler tries to determine `'a` so that `'a` $subset$ referent lifetimes of `x`
- as a result, the program we are discussing compiles
],
[
#tt(size: 16pt)[
{ \
#hh let r: &i32; \
#hh let a = 123; \
#hh { \
#hh #hh let b = 456; \
#hh #hh { \
#hh #hh #hh let c = 789; \
#hh #hh #hh #ao[r = foo(&a, &b, &c);] \
#hh #hh #hh #comm[`'a` $<- alpha$] \
#hh #hh #hh #comm[and `r`'s type becomes `&`$alpha$` i32`] \
#hh #hh } #comm[c's lifetime (= $gamma$) ends here] \
#hh } #comm[b's lifetime (= $beta$) ends here] \
#hh #aka[\*r] #comm[OK, as here is within $alpha$] \
} #comm[a's lifetime (= $alpha$) ends here] 
]
])

== Types with lifetime parameters capture/constrain the function's behavior

- what if you try to fool the compiler by:

#tt(size: 18pt)[
fn foo<#ao[`'a`],#aka[`'b`],#mido[`'c`]>(ra: &#ao[`'a`] i32, rb: &#aka[`'b`] i32, rc: &#mido[`'c`] i32) -> &#ao[`'a`] i32 { \
#hh rb \
}
]

- the compiler rejects returning `rb` (of type `&`#aka[`'b`]) when the function's return type is `&`#aka[`'a`], as it cannot infer

#hh #hh lifetime represented by #ao[`'a`] $subset$ lifetime represented by #aka[`'b`]

== References in data structures

#grid(columns: 3, gutter: 1em, align: top,
[
#tt(size: 16pt)[
struct A { b : &B } \
struct B { c : &C } \
struct C { x : i32 } \

fn baz(a : &mut A, b: &B) { \
#hh a.b = b \
}
]

does not compile
],
[$=>$],
[
#tt(size: 16pt)[
#uncover("3-")[struct A#ao[<`'b,'c`>] { b : &#ao[`'b`] B#ao[<`'c`>] }] \
#uncover("2-")[struct B#ao[<`'c`>] { c : &#ao[`'c`] C }] \
struct C { x : i32 } \
]
#only("4-5")[
#tt(size: 16pt)[
fn baz#ao[<`'a,'b,'c','d,'e`>] (a : &`'a` mut A<`'b,'c`>, \
#h(13em) b: &#ao[`'d`] B#ao[<`'e`>]) { \
#hh a.b = b \
}
]
]

#only("5")[
does not compile
]
#only("6-7")[
#tt(size: 16pt)[
fn baz<`'a,'b,'c'`>(a : &`'a` mut A<`'b,'c`>, \
#h(10em) b: &#ao[`'b`] B#ao[<`'c`>]) { \
#hh a.b = b \
}
]
]

#only("7")[
does compile
]
]
)

== Dereferencing data structure

- as stated earlier, dereferencing a borrowing pointer of type `&'a ...` is allowed at program point $p$ when:

#align(center)[$p subset$ lifetime represented by `'a`]

- the rule is actually more strict; for types involving lifetime parameters (e.g., `A<'a,'b,'c,...>`), the above applies to _all_ parameters

== Dereferencing data structure

- the following program is #ao[_safe_], but rejected by the compiler

#grid(columns: 2, gutter: 1em, align: top,
[
#tt(size: 16pt)[
struct S<`'a,'b`> { \
#hh a : &`'a` i32, \
#hh b : &`'b` i32, \
} \
#hh ... \
#hh let a = 123; \
#hh let mut s = S{a: &a, b: &a}; \
#only("1")[
#hh #box(inset: 0.2em)[{ \
    #hh let b = 456; \
    #hh s.b = &b; \
    }] \
]    
#only("2-")[
#hh #box(stroke: black, inset: 0.2em)[{ \
    #hh let b = 456; \
    #hh s.b = &b; \
    }] ... $beta$ \
]    
#hh #comm[s.b is a dangling pointer, but s.a is not] \
#hh \*s.a ... ($dagger$)
]
],
[
#uncover("2-")[
#text(12pt)[```
error[E0597]: `b` does not live long enough
  --> str.rs:11:15
   |
10 |         let b = 456;
   |             - binding `b` declared here
11 |         s.b = &b;
   |               ^^ borrowed value does not live long enough
12 |     }
   |     - `b` dropped here while still borrowed
13 |     *s.a
   |     ---- borrow later used here
```]
]
#uncover("3-")[
- `s.a` is not allowed, because:
  - the type of `s` is `S<'a,'b>` and
  - `'b` $subset beta$ ($because$ `s.b = &b`); 
  - $therefore$ $dagger$ $in.not$ `'b`
]
]
)

== Lifetime parameters in a function

- because of this restriction, the compiler can assume all lifetime parameters that appear in the function parameters contain the function body
- the compiler deduces dereferencing `a.b` below is safe based on this assumption
#grid(columns: (1em, auto),
[],
[
#tt(size: 16pt)[
fn baz<`'a,'b,'c'`>(a : &`'a` mut A<`'b,'c`>, \
#h(10em) b: &#ao[`'b`] B#ao[<`'c`>]) { \
#hh a.b = b \
}
]
])

= Summary

== Why memory management is difficult

- _every_ language wants to prevent #aka[_dereferencing a pointer to an already-reclaimed memory block (dangling pointer)_]
- the problem would have been trivial if _you could reclaim $v$'s referent as soon as $v$ goes out of scope_
- this is not the case, as #aka[_$v$'s referent may still be reachable from other variables when $v$ goes out of scope_]

#grid(columns: 2, gutter: 1em, align: top,
[
#tt(size: 16pt)[
#aka[let p : &T;]\
{\
#hh let v = T{x: ...};\
#hh ...\
#hh #aka[p = &v;]\
} #comm[v never used below, but its referent is] \
... #aka[p.x] ...
]
],
[#images("svg/L/dangling", range(1, 4), width: 70%)]
)

== C vs. GC vs. Rust

- C/C++ : it's up to you
- GC : if it is reachable from other variables, I retain it for you
- Rust : when $v$ goes out of scope,
  + I reclaim $T_v$, all data #ao[_reachable from $v$ through owning pointers_]
  + $T_v$ may be reachable from other variables via borrowing references, but I guarantee such references are never dereferenced

#align(center)[
#grid(columns: 3, gutter: 1em, align: top, 
[C/C++],
[GC],
[Rust],
[#image("svg/L/C_GC_Rust_L1.svg", width: 100%)],
[#image("svg/L/C_GC_Rust_L2.svg", width: 100%)],
[#image("svg/L/C_GC_Rust_L3.svg", width: 100%)]
)
]

== How Rust achieves it?

- say two data structures $T_v$ rooted at variable `v` and $T_p$ rooted at variable `p`
- assume `v` goes out of scope earlier than `p`
- we wish to guarantee when `v` goes out of scope, it is safe to reclaim the entire $T_v$
- generally it is of course not the case, as there may be pointers somewhere in $T_p ->$ somewhere in $T_v$

#align(center)[
  #images("svg/L/borrow_check", (1, 2), width: 40%)
]

== How Rust achieves it?

- recall the "single-owner rule," which guarantees there is only one owning pointer to any node
- $=>$ there can be #mura[_no owning pointers_] from outside $T_v$ to inside $T_v$
#uncover("2-")[- $=>$ any such pointer must be #ao[_a borrowing pointer_]]
#uncover("3-")[- recall that a borrowing pointer must have a lifetime parameter; e.g., #ao[`'a`]
- it must hold that #ao[`'a`] $subset$ lifetime of $T_v$]

#align(center)[
  #images("svg/L/borrow_check", (3, 4, 5), width: 40%)
]

== How Rust achieves it?

- any structure containing borrowing pointers must have these parameters as part of its type (e.g., #ao[`S<'a>`])
- by `'a` $subset$ lifetime of $T_v$, the containing data structure (of type `S<'a>`) cannot be dereferenced after $T_v$ is gone

#align(center)[
  #images("svg/L/borrow_check", (6, 7), width: 40%)
]
