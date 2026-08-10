# <font color="green">Memory Allocation</font>

- Investigate how memory is allocated for various kinds of data.
- In particular, when does the language allocate data from heap (not stack).
- To this end, define a function that allocates various data (structs, arrays, objects, etc.), compile it, and examine the output.
- Try the followig return typee(s)
  - Go : `Point` and `*Point`
  - Julia : `Point`
  - OCaml : `point`
  - Rust : `Point` and `Box<Point>`

## Problems

Make a note of the following:

1. Is the data allocated on the stack or on the heap?
