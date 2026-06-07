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
    title: [Garbage Collection: Basics],
    author: [Kenjiro Taura],
    date: [2026/06/08],
  ),
)

#set text(font: ("Liberation Serif", "Noto Sans CJK JP"))
#set text(size: 24pt)
#set quote(block: true)
#let ao(x) = text(fill: blue, x)
#let aka(x) = text(fill: red, x)
#let ore(x) = text(fill: orange, x)
#let mura(x) = text(fill: purple, x)
#let small(x) = text(size: 20pt)[#x]
#let blink(x, y) = link(x, text(blue, y))

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

== Two ways memory management goes wrong
- *premature free:* reclaim/reuse space for data when it may still be used in future
- *memory leak:* do not reclaim/reuse space for date when it is no longer used

== What is Garbage Collection (GC)?
- GC automates memory management, by identifying when data becomes "_never used in future_"
  - or, conversely, by identifying which data "_may be_" used in future
  
== Data that "may be" used in future ?
#grid(columns: (auto, auto), gutter: 1em, align: top,
[
#[
#set text(font: "Liberation Mono", size: 16pt)
#let t(x) = text(x)

#t("int * ")#ao("s")#t(", * ")#ao("t")#t(";
void h() { ... }

void g() {
  ... 
  h();
  ... = ")#aka("p")#t("->x ... }

void f() {
  ... 
  g()
  ... = ")#aka("q")#t("->y ... }

int main() {
  ... 
  f()
  ... = ")#aka("r")#t("->z ... }")
]
],
[
- #ao()[global variables]
- #aka()[local variables] of active function calls (calls that have started but have not finished)
#only(1)[- and ...]
#only(2)[- #ore()[objects reachable from them by pointers]]
#align(center, images("svg/L/gc_basic", range(1, 3), width: 45%))
]
)

= How GC basically works

== Terminologies and the basic principle
- _*an object:*_ the unit of data subject to memory allocation/release (malloc in C; objects in Java; etc.)
- _*the root:*_ objects accessible without traversing pointers, such as global variables and local variables of active function calls
- _*(un)reachable objects:*_ objects (un)reachable from the root by traversing pointers
- _*live objects:*_ objects that may be accessed in future 
- _*dead objects*_ or _*garbage:*_ objects that are never accessed in future

#pagebreak()

- _*collector:*_ the program (or the thread/process) doing GC
- _*mutator:*_ the user program
  - very GC-centric terminology, viewing the user program as someone simply "mutating" the graph of objects

the basic principle of GC:
#align(center)[_*objects unreachable from the root are dead*_]

= The two major GC methods (traversing GC and reference counting)

== The two major GC methods (1) --- traversing GC

- simply traverses pointers from the root, to find (or _visit_) objects _reachable from the root_
- reclaim objects not visited
- two basic traversing methods 
  - _*mark\&sweep*_ GC
  - _*copying*_ GC

== The two major GC methods (2) --- reference counting (or RC)

- during execution, _maintain the number of pointers_ pointing to each object _*(reference count)*_
- _reclaim an object when its reference count drops to zero_
  - $because$ _an object's reference count is zero $->$ it's unreachable from the root_
- note: "GC" sometimes narrowly refers to the traversing GC only

== How traversing GC works
#grid(columns: (50fr, 50fr), gutter: 1em, align: top,
[
- traverse pointers from the root
#only("6-")[- when no more "visited $->$ unvisited" pointers are found, objects that have not been visited are garbage]
],
[
#images("svg/L/ms_working", range(1, 7), width: 100%)
])
- note: the difference between mark\&sweep and copying is covered later


== How reference counting works
- each object has a _*reference count (RC)*_, the number of pointers referencing it
- update RCs during execution;
  e.g., upon #aka("p") = #ao("q")
  - the RC of the object #aka("p") points to `-= 1`
  - the RC of the object #ao("q") points to `+= 1`

== How reference counting works

#grid(columns: (auto, auto), gutter: 1em, align: top,
[
- reclaim an object when its RC drops to zero
#only("2-")[- RCs of objects pointed to by the reclaimed object decrease, which may result in reclaiming them too]
],
[
#images("svg/L/rc_working", range(1, 6), width: 100%)
]
)
#only(5)[- _*note:*_ unreachable cycles cannot be reclaimed (RC = 0 $=>$ unreachable, but _not vice versa_)]

== When an RC changes

#grid(columns: (auto, auto), gutter: 1em, align: top,
[- a pointer variable is updated], 
[#[
#set text(font: "Liberation Mono", size: 16pt)
#let t(x) = text(x)
#aka("p") = #ao("q")#text(";") #aka("p->f") = #ao("q")#text(";") etc.
]],
[- a reference is passed to a function],
[#[
#set text(font: "Liberation Mono", size: 16pt)
#let t(x) = text(x)
#t("int main() {
  object * q = ...;
  f(")#ao("q")#t("); /* rc of ")#ao("q")#t(" += 1 */
}")
]],
[- a variable goes out of scope or a function returns
- $approx$ any point when pointers get copied / dropped
- summary: _expensive_
],
[#[
#set text(font: "Liberation Mono", size: 16pt)
#let t(x) = text(x)
#t("void f(object * p) {
  ...  
  {
    object * r = ...;

  } /* RC of ")#aka("r")#t(" -= 1 */
  ...
  return ...; /* RC of ")#aka("p")#t(" -= 1 */
}")
]]
)

= Evaluating GCs

== Evaluating GCs
- #ao[preciseness:]
  - garbage that can be collected
- #ao[memory allocation cost:]
  - the work (including GC) required to allocate memory 
- #ao[pause time:]
  - the (worst case) time the mutator has to (temporarily) suspend for GC to function
- #ao[mutator overhead:]
  - the overhead imposed on the mutator for GC to function

== Criteria #1: preciseness
- #aka[_reference counting cannot reclaim cyclic garbage_]
- reference counting $<$ traversing GC (better)

#align(center)[
#image("svg/L/rc_working_L6.svg", width: 50%)
]

== Criteria #2: memory allocation cost (details ahead)
- traversing GC:
  - determined by the ratio #ao["reachable objects" / "unreachable (reclaimed) objects"] (later)
  - an advanced technique: _*generational GC*_
- reference counting:
  - the cost of reclaiming an object once its RC drops to zero is small and constant
  - constant even if memory is scarce (good)

== Criteria #3: pause time
- (better) reference counting $<$ traversing GC
- traversing GC:
  - stop the user program while it is traversing live objects
    - traverse _all_ live objects, _en masse_, and reclaim _all_ unreached objects
  - why so? troubled if the mutator runs (= changes the graph of objects) during traversing
    - a solution: _*incremental GC*_
    - generational GCs mitigate it too
- reference counting:
  - when an object's RC drops to zero (as a result of mutator's action), it can be reclaimed _immediately_
  - reclaim garbage as they arise

== Criteria #4: mutator overhead
- (better) traversing $<$ reference counting
- reference counting has a large overhead for updating RCs
- e.g.,
```c
object * p, * q;
p = q;
```

will perform:

```c
if (p) p->rc--;
if (q) q->rc++;
p = q;
```

- moreover,
  - what if it is multithreaded?
  - what if the counter overflows (how to check it)?
- techniques: _*deferred reference counting, sticky reference counting, 1 bit reference counting*_
- remark: some traversing GCs (e.g., generational and incremental) add overhead to pointer updates too

== Summary

#align(center)[
#table(columns: 3, inset: 0.3em, align: (left, center, center),
    [], [traversing GC], [reference counting],
    [preciseness], [$+$], [$-$],
    [allocation cost], [? ($ast$)], [?],
    [pause time], [$-$ ($dagger$)], [$+$],
    [mutator overhead], [$+$ ($dagger.double$)], [$-$],
)]

#small[
- ($ast$) depends on size of reachable graph and memory; _generational_ GC helps
- ($dagger$) _incremental_ GC helps
- ($dagger.double$) both _generational_ and _incremental_ GC impose some mutator overheads
]

= Two Types of Traversing Collectors

== mark&sweep GC vs. copying GC
they differ in what to do on reachable objects

- mark&sweep GC: mark them as "visited"
- copying GC: copy them into a distinct (contiguous) region

== Mark&sweep GC

- _*mark-phase:*_
  - traverses objects from the root, _marking_ encountered objects as _visited_
  - maintains _*mark stack*_, the set of objects marked but whose children may have not been marked
- _*sweep phase:*_
  - reclaims all memory blocks not visited in the mark phase
  - free memory blocks are not contiguous, so must be managed by an appropriate data structure *(_free lists_)*

== Mark&sweep GC in action

- mark stack (not shown in the figure) = light gray objects

#align(center)[
#images("svg/L/ms_algorithm", range(1, 10))
]

== Copying GC

- $approx$ copying a graph (possibly with merges and cycles)
- the crux : _pointers to the same object must remain the same after copy_
- _*semi-space GC:*_ splits the available memory into equal-sized two spaces
  - when one space fills up, copy all reachable objects to the other

== Simi-space copying GC in action

#grid(columns: 2, align: top, gutter: 1em,
[
#text(14pt)[
```
void *free, *scan;
void copy_gc() {
 free = scan = to_space;
 redirect_ptrs(root);
 while (scan < free) {
  redirect_ptrs(scan);
  scan += the size of object scan points to;
 }
 swap to_space and from_space;
}
void redirect_ptrs(void * o) {
 for (f : pointer fields of o) {
  if ([o->f] has been copied) {
   o->f = [o->f]'s forward pointer;
  } else {
   copy [o->f] to to free;
   [o->f]'s forward pointer = free;
   o->f = free;
   free += the size of [o->f];
  } } }
```
- [$p$] is the object $p$ points to (at address $p$)
]
],
[
#align(center)[
#images("svg/L/copy_working", range(1, 9))
]
])

== Simi-space copying GC : algorithm

#grid(columns: 2, align: top, gutter: 1em,
[
- invariants
  - $p < "free"$ $=>$ $p$ has been visited
  - $p < "scan"$ $=>$ $p$ has been visited; so has its direct children 
- area between scan and free serve a role similar to the mark stack
],
[
#align(center)[
#images("svg/L/copy_working", (5,6), width: 100%)
]
])

== Mark&sweep vs. copying GC

- copying GC pros:
  - live objects occupy a contiguous region after a GC
  - $->$ the free region becomes contiguous too
  - $->$ _the overhead for memory allocation is small_ (no need to "search" the free region)

#pagebreak()

- copying GC cons:
  - _copying is more expensive than marking_, obviously
  - _the free region must be reserved_ to accommodate objects copied (low memory utilization)
    - must ensure "size of objects that may be copied" $<=$ "size of the region to copy them into"
    - $->$ "from space" = "to space" (semi-space)
  - pointers must be "precisely" distinguished from non-pointers (_ambiguous pointers are not allowed_)
    - $because$ pointers are updated to the destinations of copies
    - a disaster occurs if you update non-pointers

= Memory allocation cost of traversing GCs (mark-cons ratio)

== Memory allocation cost of traversing GCs

- let's quantify _the cost of allocating a byte_ including GC's work

- assume:
  - heap size (size of a semi-space in case of copying GC) $= M$
  - reached objects $= r$
  - assume for the sake of argument it's _always $r$_

#align(center)[
#image("svg/L/mark_cons_ratio_L1.svg", width: 40%)
]

#pagebreak()

- behavior at equilibrium: the program repeats:
#uncover("2-")[+ a GC occurs $->$ _scan $r$ bytes_, to make a free space of $(M - r) $bytes]
#uncover("3-")[+ _allocate $(M - r)$ bytes_ without triggering a GC]

- a key observation:

_the time (cost) of a single GC is roughly proportional to the amount of reached objects (i.e., $prop r$)_

#align(center)[
#images("svg/L/mark_cons_ratio", range(1, 4), width: 40%)
]

== Memory allocation cost of traversing GCs

#align(center)[
#image("svg/L/mark_cons_ratio_L3.svg", width: 40%)
]

#grid(columns: 2, gutter: 1em, align: top,
[
$ & "the cost of allocating a byte" \
= & alpha + "time spent on a GC" / "space reclaimed by a GC" \
= & alpha + beta "space visited by a GC" / "space reclaimed by a GC" \
= & alpha + beta r / (M - r)
$
],
[
#text(20pt)[
- #ao[$alpha$] : an always-needed constant allocation cost per byte, even if you don't need to reclaim memory at all
- #ao[$beta$] : an average cost to examine a single byte
  - copy it (in a copying GC)
  - see if it is a pointer to an unvisited object
]  
])

== Note on copying GC vs mark-sweep GC
- the key observation
      #ao[the time (cost) of a single GC is roughly proportional to the amount of reached objects (i.e., $prop r$)]
    ignores the cost of so-called "sweep phase"
- a more accurate quantification will be
$ "the time (cost) of a single GC" approx beta r + #text(blue)[$gamma (M - r)$], $
- the second term reflects a constant cost to reclaim a byte

#pagebreak()

- i.e., the allocation cost per byte will be 
$ & alpha + (beta r + gamma (M - r)) / (M-r) \
= & alpha + gamma + beta r / (M-r) $
- $=>$ the overall characterization of the cost is the same

== Memory allocation cost of traversing GCs

- important fact:

$ "allocation cost per byte" = "constant" + prop r / (M - r) $

- $r / (M - r)$ is often called #ao[_mark-cons ratio_]. Its origin:  
  - _mark_: the amount of work to _mark_ reachable objects  
  - _cons_: the synonym of memory allocation in the ancient Lisp language, as in `(cons x y)`

== Memory allocation cost of traversing GCs

$ "allocation cost per byte" = "constant" + #text(blue)[$prop r / (M - r)$] $

- #ao[$r$] (primarily) depends only on app (not dependent on GCs)
  - note: may fluctuate depending on "when" GCs occur
- #ao[$M$] is an _adjustable parameter (up to GC's choice)_
- $M$ is large $->$ the cost is small
  - $->$ you can reduce the cost by making $M$ (memory usage) larger
  - may sound obvious, but remember that what is important is the cost _per allocation (byte)_, not the frequency of GCs

== How large do we make $M$ (memory usage)?
- alright, the larger we make $M$, the smaller the cost becomes
  - how large should we make it in practice?
- we normally set $M$ proportionally the _actual_ data size

  #text(blue)[$ M prop r $]

  i.e., choose a constant $k > 1$ and set:  

  #text(blue)[$ M = k r $]

- a GC measures the amount of reachable objects to get $r$ and sets $M$ according to the above formula

== How large do we make $M$ (memory usage)?

- in this setting:
  - allocation cost per byte
   $ = "mark-cons ratio" = r / (k r - r) = 1 / (k - 1) "(const)" $
  - memory usage
   $ prop "the size of reachable objects at a point during execution" $

- both are reasonable
  - most GCs allow you to set $k$ (or $M$ directly)
  - normally, $k = 1.5 tilde 2$, but it is worth knowing that you can reduce the cost by setting it large
