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
    title: [Memory Management: Introduction],
    author: [Kenjiro Taura],
    date: [2026/06/08],
  ),
)

#set text(font: ("Liberation Serif", "Noto Sans CJK JP"))
#set text(size: 28pt)
#set quote(block: true)
#let ao(x) = text(blue)[#x]
#let aka(x) = text(red)[#x]
#let small(x) = text(size: 20pt)[#x]
#let blink(x, y) = link(x, text(blue, y))

#let commentout(x) = ""

#let cimg(x, ..opts) = align(center, image(x, ..opts))

/* include image sequence xxx_L1.svg, xxx_L2.svg, ... */
#let images(prefix, rng, ..kwargs) = for (i, j) in rng.enumerate() [
  #only(i+1, image(prefix + "_L" + str(j) + ".svg", ..kwargs))
]

#show raw.where(block: true):  x => text(size: 16pt, pad(left: 0.7em, x))
#show raw.where(block: false): x => text(rgb(127,127,127), size: 20pt, x)

//#show raw.where(block: true):  x => text(size: 20pt, pad(left: 0.7em, x))
//#show raw.where(block: false): x => text(rgb(127,127,127), size: 20pt, x)

#title-slide()

#outline(depth: 1)

= What is memory _management_?

== Memory management in programming languages
- all data (integers, floating point numbers, strings, arrays, structs, ...) used in a program need a space (register or memory) to hold them
- desirably, programming languages should _manage_ them on behalf of the programmer; i.e.,
  - when creating a new data, find an available space for it
  - _*retain*_ the space as long as the data is still "in use"
  - _*reclaim/reuse*_ the space when the data is "no longer used"

_memory management is mainly about how to determine when the space (memory block) occupied by data can be safely reclaimed/reused_

== Approaches covered

- manual ... C, C++
- _*garbage collection (GC)*_
  - _*traversing GC*_ ... Python, Java, Julia, Go, OCaml, etc.
  - _*reference counting*_ ... Python, etc.
- Rust _*ownership system*_ ... Rust

= Data representation

== Data representation
- data in your program must be somehow _represented_ and laid out in registers and/or memory
  - primitive data (booleans, characters, integers, floating point numbers, ...)
  - multiword data (structs),
  - dynamically-sized or large data (e.g., arrays and strings),
  - recursive data (lists, trees, graphs, etc.),
  - etc.

== Two strategies

#grid(columns: (50fr,50fr), gutter: 1em,
[_*immediate (unboxed)*_ representation], [_*indirect (boxed)*_ representation],
[#image("svg/L/data_representation_L1.svg", width: 180%)],
[#image("svg/L/data_representation_L4.svg", width: 180%)]
)

== Immediate (unboxed) representation
- typically used for small data that fit one or a few machine words (integers, floats, characters, small structs, etc.),
#uncover("2-")[- upon an assignment-like operation, the whole data gets copied (cheap as data are small)]

#align(center)[#images("svg/L/data_representation", range(1,4), width: 60%)]

== Indirect (boxed) representation

#grid(columns: (60fr, 40fr), align: top,
[- used for all other data
  - dynamically-indexed (string, arrays, etc.)
  - dynamically-sized (string, arrays, etc.)
  - recursive data (list node, tree node, graph node, etc.)
  - large data
],
[#image("svg/L/data_representation_L4.svg", width: 200%)]
)

== Assignment of indirectly represented data

- upon an assignment-like operation of indirectly represented data, there are two choices:
+ _*copy-by-value:*_ allocates memory and copies the data
+ _*copy-by-reference:*_ copies the address _*(pointer)*_ and _shares_ data in memory

== Copy-by-value

#images("svg/L/data_representation", (5, 6), width: 100%)

== Copy-by-reference

#images("svg/L/data_representation", (5, 7), width: 100%)

== Copy by-value vs. by-reference

- besides the cost of copy, it affects _behavior (semantics)_ of _mutable_ data

```python
a = point(x: 10, y: 20)
b = a         # copy-by-value? or reference?
b.x = 100
print(a.x)    # 10 if by-value, 100 if by-reference
```

- if the language spec says it should print 100 in this program, `point` objects should be copied by reference

== A terminology note

- many programming languages employ this semantics for all mutable data and therefore implement them by copy-by-reference
- we casually say such data is implemented by _*pointer*_

#align(center)[#image("svg/L/data_representation_L7.svg", width: 70%)]

== Why memory management is difficult at all?

- were there no data implemented by copy-by-reference, memory management problem would be largely non-existent
- $because$ if all data were immediate or copied upon assignment
  - $=>$ two pointers never point to the same memory block
  - $=>$ if a pointer is gone (e.g., a pointer variable goes out of scope), the memory block it points to (and all data reachable from it) can be safely reclaimed

#pagebreak()

- it is difficult precisely because some data are (_and must be_) implemented by copy-by-reference
  - $=>$ the same memory block may be pointed to by multiple references
  - $=>$ even if a pointer is gone, other pointers may still exist and data may still be used

= Memory management in C/C++

== Three types of memory in C/C++

- #text(fill: blue)[global] variables/arrays (defined at the toplevel)
- #text(fill: red)[local] variables/arrays (define inside a function)
- #text(fill: orange)[heap] (malloc, new)

#[
#set text(font: "Liberation Mono", size: 16pt)
#text(fill: blue, " int g; int ga[10];
")
int foo() {
#text(fill: red, "
  int l; int la[10];")
#text("
  int * a = &g;
  int * b = ga;
  int * c = &l;
  int * d = la;
  int * e =")
#text(fill: orange, "malloc(sizeof(int));
")
}
]

== Lifetime

- _*lifetime*_ of a memory block (variable, array, heap-allocated block) refers to the period in which it is valid (i.e., remembers the last-written data)

#align(center, [
#table(columns: (auto,auto,auto), align: left,
[],       [starts],                  [ends],
[global], [when the program starts], [when program ends],
[local],  [when a block starts],     [when a block ends],
[heap],   [malloc, new],             [free, delete]
)
])

- note: lifetime of _static_ variables/arrays is the same as #ao[global]
- note: the discussion below calls memory blocks _objects_

== What can go wrong in C/C++ (local variable/arrays)

- unconditionally reclaimed when it goes out of scope
- yet there may be a pointer still pointing to it

#[
#set text(font: "Liberation Mono", size: 16pt)
#let text_red(x) = text(fill: red, x)
#text("node * foo() {
  node m = node(\"Mimura\");
  node o = ")#text_red("node(\"Ohtake\")")#text(";
  return ")#text_red("&o")#text("; // m and o gone here
}")

#text("node * foo() {
  node m = ")#text_red("node(\"Mimura\")")#text(";
  node * o = new node(\"Ohtake\");
  o->friend = ")#text_red("&m")#text(";
  return o; // m gone here
}")
]

== What can go wrong in C/C++ (heap-allocated objects)

- lifetime ends with and only with free/delete by the programmer

#[
#set text(font: "Liberation Mono", size: 16pt)
#let text_red(x) = text(fill: red, x)
#text("node * foo() {
  node * m = ")#text_red("new node(\"Mimura\")")#text(";
  node * o = m;
  delete m; // ")#text([_o still points to it_])#text("
  ... o->name ...
}")

#text("node * foo() {
  node * m = ")#text_red("new node(\"Mimura\")")#text(";
  node * o = new node(\"Ohtake\");
  return o;
}")
]

== Are pointers to blame?

- to some extent yes, but note
- eliminating pointers from your language is _not_ a solution
  - some data are (and must be) implemented with "copy-by-reference"
- if an object (memory block) may be pointed to by multiple pointers (whether _pointers_ are visible to the programmer), there is a problem of _how to determine when it's safe to reclaim_
