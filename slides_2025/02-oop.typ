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
    title: [Object-Oriented Programming],
    author: [Kenjiro Taura],
//    date: [2024/04/28],
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

#let comment(x) = ""

#title-slide()

#outline(depth: 1)

= Before object-oriented programming

== Composite data

- composing multiple values into one is a fundamental mechanism in any programming language
- common mechanisms: arrays, lists, tuples, pairs, etc.
- they allow large collection of values to be referenced by a single variable, hiding details (abstraction)

== New data types

- programming languages also allow you to _introduce new composite data_
    - Python: class
    - C++: struct/class
    - Go: struct
    - Julia: struct
    - OCaml: variant, record, class
    - Rust: struct, enum
    - ...

= What is object-oriented programming?

== What is object-oriented programming?

#quote(attribution: [Wikipedia])[
_... Object-oriented programming (OOP) is a programming paradigm based on the concept of *objects*.  Objects can contain data (called fields, attributes or properties) and have actions they can perform (called procedures or *methods* and implemented in code)._
]

== Classes and objects : taxonomy

- _*class-based*_ : in many languages, you first define a _*class*_ ($approx$ template of objects)
  - an object is made from a class (object = _*instance*_ of a class)
  - C++, Python, Go, Julia, Rust
- _*prototype-based*_ or _*classless*_ : in other languages, you can create an object with or without defining a class
  - an object can be made by a generic object expression or from a class 
  - Javascript, OCaml

== Classes and objects : examples

#grid(columns: (auto, auto), align: top, row-gutter: 20pt,
[Python class definition], [Object creation],
[
```python
class point:
  def __init__(self, x, y):
    self.x = x;
    self.y = y;
```],
[```python
a = point(1.2, 3.4)
```])

== Classless object creation : example

#grid(gutter: 24pt,
[Javascript],
[
```javascript
let a = { "x" : 1.2, "y" : 3.4 }
```],
[OCaml (classless)],
[
```ocaml
let a = object method x = 1.2 method y = 3.4 end
```],
[OCaml (with class)],
[
```ocaml
class point (x : float) (y : float) =
  object method x = x method y = y end;;
let a = new point 1.2 3.4
```],

)

== Relevant keywords/syntax in our languages

#align(center,
table(columns: (auto, auto, auto), inset: 10pt, align: left,
[language], [class definition],        [object creation],
[Go],       [`type Point struct ...`], [`Point(1.2, 3.4)`],
[Julia],    [`struct Point ...`],      [`Point(1.2, 3.4)`],
[Rust],     [`struct Point ...`],      [`Point(1.2, 3.4)`],
[OCaml],    [`class point ...`],       [`object ... end` or \ `new point ...`]
))

== Methods

- method $approx$ function or procedures in any other language
- so what is different?
  - _multiple definitions_ of a method of the same name can exist
    - e.g., an `area` method for `rectangle`, `circle`, `triangle`, etc.
  - _*dynamic dispatch*_ : when calling a method, which one gets called depends on which objects it is called for

== Dynamic dispatch : taxonomy

- _*single dispatch*_ : many languages determine which method gets called by the type of a _single_ argument ("_receiver_" object)
  - C++, Python, Go, OCaml, Rust
- _*multiple dispatch*_ : some languages determine which method gets called by the types of _multiple_ arguments (objects)
  - Julia

== Single dispatch : example
- multiple definitions of `area` method in Python

#grid(columns: (auto, auto), align: top, gutter: 20pt,
[```python
class circle:
  ...
  def area(self):
    r = self.r
    return pi * r * r
```],
[```python
class rect:
  ...
  def area(self):
    return self.w * self.h
```])

- dispatch, based on whether `s` is `circle` or `rect`
```python
shapes = [circle(...), rect(...)]
for s in shapes:
  s.area()  # method call (s is the receiver)
```

== A single dispatch in Julia

- multiple definitions of `area` method in Julia
#grid(columns: (auto, auto), align: top, gutter: 20pt,
[```julia
function area(c :: Circle)
  pi * c.r * c.r
end  
```],
[```julia
function area(r :: Rect)
  r.w * r.h
end  
```])

- dispatch, based on whether `s` is `circle` or `rect`
```python
shapes = [Circle(...), Rect(...)]
for s in shapes
  area(s)
end  
```

== Multiple dispatch in Julia
- let's say we define a method `contains(`$a$`, `$b$`)` that computes whether $a$ contains $b$
- Julia allows you to define it based on _both_ $a$ and $b$

```julia
function contains(c0 :: Circle, c1 :: Circle) ...
function contains(c0 :: Circle, r1 :: Rect) ...
function contains(r0 :: Rect,   c1 :: Circle) ...
function contains(r0 :: Rect,   r1 :: Rect) ...
```

== Power of dynamic dispatch
- dynamic dispatch allows a single piece of code to work on many different kinds of data. e.g., 
- the following Python code
```python
def sum(a, v0):
  v = v0
  for x in a:
    v += x
  return v
```
which is equivalent to
```python
def sum(a, v0):
  v = v0
  it = a.__iter__()
  try:  
    while True:          # = for x in a
      x = it.__next__()
      v = v.__iadd__(x)  # v += x
  except StopIteration:
    pass
  return v
```
works for _any_ `a` (and `v0`) satisfying the following
- `v0` has a method `__iadd__(x)`, which takes a parameter and returns anything that also has a method `__iadd__(x)`, which takes a parameter and returns anything that also has a method `__iadd__(x)`, which ...
- `a` has a method `__iter__()`, which
  - returns anything that has a method `__next__()`, which returns anything for which `v.__iadd__` works, ... (details omitted) ..., and
  - eventually raises `StopIteration`

- this is the reason why Python's for loop works for lots of data
  - lists, tuples, strings, dictionaries,
  - file handles,
  - numpy arrays
  - database query results,
and you can _define_ your data structure for which the same code just works

= Type Systems

== Types

- _*types*_ in programming languages $approx$ _kind_ of data. e.g.,
  - integers, floating point numbers, array of integers, ...
  - there are user-defined types (e.g., `circle`, `rect`, etc.)
- the type of data generally determines what operations are valid on it, e.g.,
  - `s.area(...)` is valid if `s` is a `circle, rect,` or other type that defines an `area` method
  - `a[i] = x` is valid if `a` is an array, or other type that supports indexed assignment (`..[..] = ...`)

== Type errors at runtime

- at runtime, each data naturally has its type (_*dynamic type*_ or _*runtime type*_)
- when an operation not defined on the runtime type of data is applied, a _*runtime type error*_ results.
- e.g., Python code below gets an error in the third iteration
```python
shapes = [circle(...), rect(...), (3,4)]
for s in shapes:
  s.area()
```

== Runtime vs. static type checking

- some languages perform type checking _during_ execution (_*runtime type checking*_), which aborts the program with error messages when detected
  - Python, Javascript, Julia, ...
- some languages (_*statically typed*_ languages) perform type checking _before_ execution (_*static*_ or _*compile-time type checking*_), which refuses to execute programs containing certain errors
  - C, C++, Java, Go, OCaml, Rust, ...

== Static type checking and type safety

- some statically typed languages _guarantee_ that no runtime type errors will happen for programs that pass static type checking (_*type safe*_ languages)
  - Go, OCaml, Rust, ...
- it generally works by
  - calculating _the *static* or *compile-time* type of each expression_, and
  - judging the validity of each operation by static types,
  - before execution
- some languages do _not guarantee_ no runtime type errors despite static type checking
  - some employ complementary runtime type checks, too (Java)
  - some forgo runtime type checks altogether; when a type error happens at runtime, it may cause _segmentation fault_ or even worse, _data corruption_ (C, C++)
    - you will see why later in the course (assembly languages and compilers)


== A static type checking example (a hypothetical Python-like language)
```python
l = [circle(..), circle(..)]
for c in l:
  c.area()
```
- static types  ("_expr_ : _type_" means _expr_ has _type_)
  - `circle(..)` : circle
  - `[circle(..), circle(..)]` : list of circle
  - `l` : list of circle
  - `c` : circle
  - `c.area()` : float
- this program is _*(well-)typed*_ and never causes a runtime error  

== An example containing an error
```python
l = [(3,4), (5,6)]
for p in l:
  p.area()
```
- static types 
  - `(3,4)` : pair of int
  - `[(3,4),(5,6)]` : list of pair of int
  - `l` : list of string
  - `p` : pair of int
  - `p.area()` : #aka[error] (`area` on pair of int)

== Is type safety difficult to achieve?

- in a simple case, no
- specifically, it is not difficult if the static type of an expression _*uniquely*_ determines its runtime type
  - we call such a language _*simply typed*_
  - in simply typed languages, each expression or variable can take values of only a single runtime type
- Q : what's wrong with simply typed languages?

== Why simply typed languages do not suffice?
- they are _inflexible_ and hinder _code reusability_. e.g.,
- e.g., cannot put elements of different types in a single container
 ```python
l = [rect(..), circle(..)]
for s in l:
  s.area() # what is the static type of s??
```

== Why simply typed languages do not suffice?
- e.g., cannot have a single function definition of an array of different types, even when element type should not matter
```python
def n_elems(l): # list of what?
  n = 0
  for x in l:
    n += 1
  return n

n_elems([1,2,3])
n_elems(["a", "b", "c"])
```   

== Polymorphism

- in each of the examples, a single expression can take values of different types at runtime
#grid(columns: (auto,auto), gutter: 20pt, align: top,
[```python
l = [rect(..), circle(..)]
for s in l:
  s.area()
```],
[```python
n_elems([1,2,3])
n_elems(["a", "b", "c"])
```])
- a variable or expression is said to be _*polymorphic*_ when it can take values of different runtime types
- a language is said to support _*polymorphism*_ when it allows polymorphic variables or expressions

= Polymorphism and type safety

== Polymorphism and type safety

- forget about type safety $=>$ polymorphism is easy to achieve
  - Julia, Python, Javascript, or many scripting languages
- forget about polymorphism (i.e., settle for simply typed languages) $=>$ type safety is easy to achieve
- achieving _*both*_ polymorphism and type safety is difficult

== Static type system for polymorphism
- informally, we need a static type that can represent multiple dynamic types
- two broad categories
+ _*subtype polymorphism*_ : allows a single static type that accommodates multiple types
+ _*parametric polymorphism*_ : allows a static type having _parameter(s)_, which can be instantiated into multiple types

== Subtype polymorphism example

- introduce a "shape" type, which accommodates both rect and circle, and let `s` have type "shape"
 ```python
l = [rect(..), circle(..)]
for s in l:
  s.area()
```
- in this example, we say `rect` (and `circle`) is a _*subtype*_ of `shape`
- or, `shape` is a _*supertype*_ of `rect` (and `circle`)
- more on this later

== Parametric polymorphism

- `n_elems` has a static type (like "$forall alpha . "array of" alpha -> "int"$"), which can be instantiated into "array of int $->$ int" and "array of string $->$ int"
```python
n_elems([1,2,3])
n_elems(["a", "b", "c"])
```
- we'll cover this more in the next week

== How static type checking works with subtyping
- consider the following program in a hypothetical Python-like language
```python
def small(s : shape) -> bool:
  return s.area() < 10.0

small(rect(..))  # or small(circle())
```

== Type checking the function

- define the `shape` type somewhere, in such a way that `shape` has `area()` method returning `float`
```python
type shape = ... area ...  # hypothetical
```
- and define `small` to take `shape` as input
```python
def small(s : shape) -> bool:
  return s.area() < 10.0
```

== Type checking the function
```python
def small(s : shape) -> bool:
  return s.area() < 10.0
```

- ```python s``` : ```python shape```
- $=>$ ```python s.area()``` : ```python float```
- $=>$ ```python s.area() < 10.0``` : ```python bool```

- similar to the simply-typed case

== Type checking the function call
```python
small(rect(..))
```

- ```python rect(..)``` : ```python rect```
- ```python small``` : ```python shape -> bool```

- must allow _*passing argument of type ```python rect``` (and ```python circle```) to a parameter of type ```python shape```*_
  - ```python shape``` $<-$ ```python rect```
  - ```python shape``` $<-$ ```python circle```

- i.e., _*treating a value of type ```python rect``` as if it is of type ```python shape```*_


== In general ...

+ an operation (e.g., method call) is judged valid when _static type_ of respective subexpression defines that operation
  - e.g., `s.area()` is valid as the static type of `s` is `shape`, which (we assume) defines `area` method
+ passing argument of $T$ to formal argument of type $S$ (or _treating $T$ as if it is $S$_, which we denote as by $S <- T$) is judged valid _*when doing so is safe*_
  - e.g., `small(rect(..))` is judged valid as `shape` $<-$ `rect` seems safe (but why?)

== When is $S <- T$ safe?

- informally, $S <- T$ is safe when _*any operation applicable to $S$ is also applicable to $T$ ($ast$)*_ (_Liskov substitution principle_)
  - ex: "`shape` $<-$ `rect`" is safe, because operation applicable to `shape` will be applicable to `rect` (note: whether it's true depends on how they are actually defined, of course)
  - intuitively, safe when "$T$ is a kind of $S$"
    - ex: `rect` (`circle`) is a kind of shape
    - but this intuitive reasoning breaks later (keep awake!)

== When do we need to consider safety of $S <- T$?

- assignment:
```python
x : shape = rect(...) ```
- passing argument:
```python
def f(x : shape):  ...```

```python
f(rect(...))```

- returning from a function
```python
f (...) -> shape:
  return rect(...)
```
- conditional expression
```python
rect(...) if ... else circle(...) : shape
```
- heterogeneous list
```python
[ rect(...), circle(...), ... ] : list of shape
```

- in all cases, we are treating an expression of type `rect` (`circle`) as `shape`

/*
== Note: what is "assignment-like" operation?
- intuitively, any operation that flows a value to another place
  - assignment (left hand side : $S$ $<-$ right hand side $T$)
  - passing arguments (formal arg : $S$ $<-$ actual arg : $T$)
- more generally, any operation where a value of static type $T$ is interpreted as a value of static type $S$. e.g.,
  - returning a value of $T$ from a function whose declared return value is $S$
  - conditional expression whose clauses have different types $T_0$ and $T_1$
*/

== Subtype
- we write $T <= S$ and say $T$ is a _*subtype*_ of $S$ (and $S$ is a _*supertype*_ of $T$) when the condition ($ast$) is the case
  - ex: `rect` $<=$ `shape`, `circle` $<=$ `shape`
- with this terminology, _*treating a value of $T$ as $S$ ($S <- T$) is safe simply when $T <= S$*_

- if we think of a type as a set, $<=$ represents a subset relation
  - this intuition breaks again later (keep awake!)

= Establishing subtype relationship

== A model language

+ some primitive types (imagine integers, floating point numbers, characters, etc.)
+ _*record-like types*_
    - class, struct, etc.
    - arrays $approx$ structs whose fields are integers
    - methods $approx$ functions in a record
+ _*functions*_

== Subtype relationships between record-like types

- when both $S$ and $T$ are record-like types, the following conditions *($dagger$)* must hold for $T <= S$
  + $T$ has all the (public) methods/fields of $S$
  + for each (public) field or method $m$,
    $ "type of" m "in" T <= "type of" m "in" S $
  + if field $m$ is _*mutable*_, 
    $ "type of" m "in" T = "type of" m "in" S $

#pagebreak()

- *($dagger$)* are _necessary_ conditions to achieve type safety
    - a language designer can make it stronger (i.e., more prohibitive or less permissive) without breaking type safety
    - making it more permissive could risk type safety

== Subtype relationship example (1)

- Q: `rect` $<=$ `shape` (is `shape` $<-$ `rect` safe)?

#let code_block_widths = (380pt, 380pt)
#grid(columns: code_block_widths, align: top, column-gutter: 0pt, [```python
class shape:
  def area(self)->float: ...
```],[```python
class rect:
  def area(self)->float: ...
  def width(self) ...
  def height(self) ...
```])

#uncover(2)[- A: Yes]

== Subtype relationship example (2)

- Q: `rect` $<=$ `shape` (is `shape` $<-$ `rect` safe)?
#grid(columns: code_block_widths, align: top, [```python
class shape:
  def area(self)->float: ...
  def perimeter(self) ...
```],[```python
class rect:
  def area(self)->float: ...
  def width(self) ...
  def height(self) ...
```])

#uncover(2)[- A: (Obviously) no
```python
s : shape = rect(..)
s.perimeter()
```]

== Subtype relationship example (3)

- What if the same field has different types?
- assume `rect` $<=$ `shape` and `shape` $lt.eq.not$ `rect`
- `s` is public (visible from outside)
- Q1: `shape_cell` $<=$ `rect_cell` (is `rect_cell` $<-$ `shape_cell` safe)?
- Q2: `rect_cell` $<=$ `shape_cell` (is `shape_cell` $<-$ `rect_cell` safe)?

#grid(columns: code_block_widths, align: top, [```python
class shape_cell:
  def __init__(self, s):
      self.s : shape = s
```
],[```python
class rect_cell:
  def __init__(self, s):
      self.s : rect = s
```
])

== Subtype relationship example (3)

#grid(columns: code_block_widths, align: top, [```python
class shape_cell:
  def __init__(self, s):
      self.s : shape = s
```
],[```python
class rect_cell:
  def __init__(self, s):
      self.s : rect = s
```
])

#uncover("2-")[- A1: No
```python
rc : rect_cell = shape_cell(any_shape())
rc.s.width()
```
]
#uncover(3)[- A2: Yes if `s` is immutable; #aka[No if `s` is _mutable_]]

== If s is mutable ...

```python
rc : rect_cell = rect_cell(rect())
sc : shape_cell = rc
sc.s = any_shape()  # may not be rect
rc.s.width()        # width not found!
```
- this shows `shape_cell` $<-$ `rect_cell` is _not_ safe

== Subtype relationship example (4)

- Q: `array of rect` $<=$ `array of shape` (is `array of shape` $<-$ `array of rect` safe)?
- assume `rect` $<=$ `shape`
#uncover(2)[- A: No, if arrays are mutable
```python
ar : array of rect = [rect(), rect()]
as : array of shape = ar
as[0] = any_shape()  # may not be rect
ar[0].width()        # width not found!
```
- the same as the example (3)
]

== A side story --- Java

```python
ar : array of rect = [rect(), rect()]
as : array of shape = ar
as[0] = circle()
ar[0].width()   # calling .width() on circle()!
```

- Java got it wrong and allows this assignment
  - a _runtime_ exception occurs at ```java as[0] = circle()```
- there is another OOP language, called Eiffel, that got it wrong
  - anything (segfault or returning junk data) can happen at ```eiffel ar[0].width()```

== A side story --- Julia

- Julia allows this assignment, too
```julia
ar :: Vector{Rect} = [Rect(..), Rect(..)]
as :: Vector{Shape} = ar
as[1] = circle()
ar[1].width()   # calling .width() on circle()!
```
but ```julia as : Vector{Shape} = ar``` creates a copy of `ar` (wierd)

#comment[
== A similar example --- recursive types

- Q: `node_w_color` $<=$ `node` (is `node` $<-$ `nodw_w_color` safe)?
#grid(columns: code_block_widths, align: top, [```python
class node:
  def __init__(self):
    self.left : node
    self.right : node
```],[```python
class node_w_color:
  def __init__(self, col):
    self.left : node_w_color
    self.right : node_w_color
    self.color = col
```])

#uncover(2)[- A: Yes only if `left` and `right` are immutable]

== If left (or right) is mutable ...

```python
nc : node_w_color = node_w_color("red")
no : node = nc
no.left = node()
nc.left.color    # calling .color on node!
```

- this shows `node` $<-$ `nodw_w_color` is _not_ safe

/*
- for reasoning, just consider having mutable field `sib : `$T$ is equivalent to having a method `set_sib(`$s$ : $T$`)`
  - node has `set_sib(s : node)`
  - node_w_color has `set_sib(s : node_w_color)`
*/
]

== Subtype relationship between functions

- suppose both $S$ and $T$ are function types:
    - $S = A -> B$
    - $T = A' -> B'$
- for $T <= S$, it must be that
  $ #ao[$B' <= B$] "and" #aka[$A' >= A$] $
- to see why, assume $f'$ : $A' -> B'$ and $f$ : $A -> B$,
- and ask when $f <- f'$ is safe?

#pagebreak()

- recall substitution principle ($ast$)
- $f'$ must be able to replace safely $f$. i.e.,
    + $f'(a)$ must be valid for any $a : A$ #h(1em) $=>$ #aka[$A' >= A$]
    + $f'(a) : B$ must hold for any $a : A$ #h(1em) $=>$ #ao[$B' <= B$]

== Understanding subtyping between functions

- the first condition may be counterintuitive at first
- analogy
    - a function #aka[$A$] $ -> B$ is like an animal that eats #aka[$A$] and emits $B$
    - carnivore (肉食) $= #aka[meat] -> "pXXp"$
    - ominivore (雑食) $= #aka[any food] -> "pXXp"$
    - _"ominivore can eat any thing carnivore can eat"_ \
        $=>$ omnivore can replace carnivore \
        $=>$ $"omnivore" <= "carnivore"$
- note: analogy between subtyping and set inclusion is broken

== Covariant and contravariant
- in general, a type $T(alpha)$ parameterized by $alpha$, is said to be
  - _*covariant on $alpha$*_ if replacing $alpha$ with its subtype $alpha'$ yields its subtype (i.e., $alpha' <= alpha => T(alpha') <= T(alpha)$)
  - _*contravariant on $alpha$*_ if replacing $alpha$ with its supertype $alpha'$ yields its subtype (i.e., $alpha' >= alpha => T(alpha') <= T(alpha)$)

- in this terminology, a function type is
  - _covariant_ on output ($B' <= B => A -> B <= A -> B'$)
  - _contravariant_ on input ($A' <= A => A' -> B <= A -> B$)

== Subtype relationship example (5) --- a method taking different types

- two `eq` methods take different parameters
- Q : `rect` $<=$ `shape` (assignment `shape` $<-$ `rect` safe)?
#grid(columns: 2, align: top, [```python
class shape:
  def area(self): ...
  def eq(self, s:shape): ...
```],[```python
class rect:
  def area(self): ...
  def eq(self, s:rect): ...
  def width(self): ...
  def height(self): ...
```])


#pagebreak()

- A : No

```python
s : shape = rect(..)
s.eq(any_shape(..))
```
- would pass a `circle` to a formal argument of `eq` (`rect` type)

#pagebreak()
- to reason more algorithmically,

`rect` $<=$ `shape` \
$=>$ (type of `eq` in `rect`) $<=$ (type of `eq` in `shape`) \
$=>$ `rect` $->$ `bool` $<=$ `shape` $->$ `bool` \
$=>$ `shape` $<=$ `rect` (contravariant)

but this is clearly false



= Subtypes in actual languages : a taxonomy

== Taxonomy of subtype relationships

_*interface*_ subtyping vs. _*concrete-type*_ subtyping

- concrete-type subtyping (C++, Java, OCaml)
  - $<=$ is introduced between ordinary (concrete) types
- interface subtyping (Go, Rust, Julia)
  - besides ordinary types, define _abstract types_ (Julia), _interfaces_ (Go), or _traits_ (Rust)
  - $<=$ is introduced only between interfaces or between a concrete type and an interface
#pagebreak()    

_*nominal*_ subtyping vs. _*structural*_ subtyping
- nominal (Julia, Rust)
  - $<=$ holds only when the programmer so specified explicitly
    - Julia: `struct` $T$ `<:` $S$
    - Rust: `impl` _trait_ `for` _struct_
- structural (Go, OCaml)
  - $<=$ is derived automatically from definitions

== Go
```go
type Shape interface { area() float64 }
type Rect struct { ... }
func (r Rect) area() float64 { ... }
```
- with Go structural subtyping, `Rect` $<=$ `Shape` is _automatically_ established because `Rect` has an `area` method returning `float64`, allowing the following assignment
```go
var s shape = rect{0, 0, 100, 100}
```

== Julia

- does not need anything specific to define functions on `struct`
```julia
struct Rect ... end
struct Circle ... end
function area(r :: Rect) ... end
function area(c :: Circle) ... end
```

#pagebreak()

- if you want to define a single function body that works _both_ on `Rect` and `Circle`, you can use an abstract type. e.g.,
```julia
abstract type Shape ... end
struct Rect <: Shape ... end
struct Circle <: Shape ... end
function dist(s :: Shape) ... end
```

== Rust
```rust
trait Shape { fn area(&self) -> f64;  }
struct Rect { ... }
impl Shape for Rect {
  fn area(&self) -> f64 { ... }
}
```
- with Rust (nominal subtyping between struct and trait), `Rect` $<=$ `Shape` is established by explicitly stating `impl Shape for Rect`, allowing the assignment below
```rust
let s : &dyn Shape = &Rect{ ... };
```

== OCaml --- purely structured subtyping
- OCaml requires no type (class) definitions to make objects
- every expression/variable still has static types (the name may be lacking)
- type of an object expression is automatically derived from methods
- e.g., the "object expression" below has a type `< area: float >`
```ocaml
object method area = 10.0 end
```
- `class` is just a way to give a name to an object type

== OCaml --- purely structured subtyping
- even if two object types have different names, they are the same if their signatures (methods and their types) are the same
- the following just works if `rect` and `circle` have identical signatures
    - ```ocaml [new rect(); new circle(); ...]```
    - ```ocaml if ... new rect() else new circle()```
- otherwise you need a _type cast_ to indicate a common supertype

== OCaml --- type cast

- you can use _type cast_ `(`$e$ `:>` $S$`)` to treat $e$ as if it is $S$
  - valid only when $e$'s static type $T <= S$
  - not the cast as you may know it in C/C++
- e.g., if `rect` and `circle` are different but both have `area : float`, 
  - ```ocaml type shape = < area : float >```
  - ```ocaml [(new rect() :> shape); (new circle() :> shape); ...]```
