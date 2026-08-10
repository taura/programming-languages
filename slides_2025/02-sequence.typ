#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
//#import themes.university: *
//#import themes.aqua: *
//#import themes.dewdrop: *
//#import themes.simple: *
//#import themes.stargazer: *
//#import themes.default: *
//#import "@preview/numbly:0.1.0": numbly

#set text(font: ("Liberation Serif", "TakaoMincho"))
//#set text(font: ("Liberation Serif", "Noto Serif CJK JP"))
#set text(size: 11pt)
#let small(x) = text(size: 9pt)[#x]

#let ao(x) = text(blue)[#x]
#let aka(x) = text(red)[#x]
#let blink(x, y) = ao(link(x, y))
#let indent(b) = grid(columns: (2em, auto), [], b)

/* #images("svg/foo", (2,4,7), start: 3)
-> include image sequence svg/foo_L2.svg, svg/foo_L4.svg, and svg/foo_L7.svg
   at 3, 4, 5 */
#let images(prefix, rng, start: 1, ..kwargs) = for (i, j) in rng.enumerate() [
  #only(i+start, image(prefix + "_L" + str(j) + ".svg", ..kwargs))
]

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Sequence Data Types],
    author: [Kenjiro Taura],
    date: [],
  ),
)

#title-slide()

#outline(depth: 1)

== What is sequence data?

- data that represents sequence of data
- virtually every language supports some sort of it
    - arrays, slices, vectors, list, etc.
- there are some variations

== Example: Python list

- make a list
```
s = [3, 6, 7]
```
- update an element
```
s[1] = 5  # s is now [3,5,7]
```
- add a new element 
```
s.append(11)    # s == [3,5,7,11]
s.insert(0, 2)  # s == [2,3,5,7,11]
```
- make another, extended list
```
t = s + [13,17] # t == [2,3,5,7,11,13,17]
# s is still [2,3,5,7,11]
```

== Example: C array

- make an array
```
int s[3] = {3, 6, 7};
```

```
int * s = malloc(sizeof(int) * 3);
s[0] = 3; s[1] = 6; s[2] = 7;
```

- update an element
```
s[1] = 5  # s is now [3,5,7]
```
- you can't add a new element (can't change the size)
- no convenient way to make another, extended list
    - just allocate another larger array, copy old contents, write the extra element

== Taxonomy

- immutable : cannot update data in place
- mutable : can update elements in place
    - fixed-size : cannot change the number of elements (i.e., cannot add/remove elements)
    - variable-size : cannot change the number of elements (i.e., cannot add/remove elements)

== Overview of sequence data in Go/Julia/OCaml/Rust

- Go
    - array
    - slice
- Julia
    - array
    - vector
- OCaml
    - list
    - array
- Rust
    - array
    - vector (Vec)

== Things to master

- _expression_ to make a sequence (Python: `[1,2,3]`)
- _type expression_ to declare a variable for sequence 
- how to access an element (`a[i]`)
- how to scan all elements (`for x in a: ...`)
- mutable or immutable?
    - if mutable, how to update an element in place (`a[i] = x`)
- fixed-size of variable-size?
    - if variable-size, how to add/remove an element (`a.append(x)` etc.)
- _functional_ update
    - how to make a new sequence with additional/updated element(s) (`a + [x]` etc.)

== Julia vector ($approx$ Python list)

- one-dimensional array is called a `vector`
- mutable / variable-size
- expression : `[1,2,3]`
- `s = [1,2,3]`                # s : [1,2,3]
- ref
    - `s[1]`                       # 1
- update
    - `s[1] = 100`                 # s : [100,2,3]
- add
    - `push!(s, 4)`                # s : [100,2,3,4]
    - `pushfirst!(s, 0)`           # s : [0,100,2,3,4]
    - `insert!(s, 3, 200)`         # s : [0,100,200,2,3,4]
- delete
    - `pop!(s)`                    # s : [0,100,200,2,3]
    - `popfirst!(s)`               # s : [100,200,2,3]
    - `deleteat!(s, 3)`            # s : [100,200,3]
- concatenate (functional)
    - `t = vcat(s, [4, 5])`        # t : [100,200,3,4,5], s : [100,200,3]

== OCaml list

- _#ao[immutable]_
- expression : `[3; 6; 7]`
- `let s = [1; 2; 3]`
- `let t = 0 :: s`         # t : [0; 1; 2; 3], s : [1; 2; 3]
- `let u = t :: [4; 5]`    # u : [0; 1; 2; 3; 4; 5]

== OCaml array

- _#ao[mutable / fixed-size]_
- expression : `[|3; 6; 7|]`
- `let s = [|1; 2; 3|]`
- `let t = 0 :: s`         # t : [0; 1; 2; 3], s : [1; 2; 3]
- `let u = t :: [4; 5]`    # u : [0; 1; 2; 3; 4; 5]

== Rust array

- _#ao[mutable or immutable / fixed-size]_
- `let a = [1, 2, 3];`
- `let mut a = [1, 2, 3];`
- `a[i]`
- `a[i] = x;`

== Rust vector

- _#ao[mutable or immutable / variable-size]_
- `let mut a = [1, 2, 3];`
- `a[i]`
- `a[i] = x;`
- `a.push(4);` // a : [1, 2, 3, 4]
- `a.push(5);`			// a : [1, 2, 3, 4, 5]
- `a.insert(0, 0);`	 // a : [0, 1, 2, 3, 4, 5]
- `a.insert(2, 200);`	 // a : [0, 1, 200, 2, 3, 4, 5]
- `a.insert(2, 200);`	 // a : [0, 1, 200, 2, 3, 4, 5]
- `a.extend(vec![6, 7, 8]);`	// a : [0, 1, 200, 3, 4, 5, 6, 7, 8]
- `a.pop();`			// a : [0, 1, 200, 3, 4]
- `a.remove(3);`		// a : [0, 1, 200, 3, 4, 5]
- `let b = [a, vec![9, 10, 11]].concat();` // b : [0, 1, 200, 3, 4, 5, 9, 10, 11]

