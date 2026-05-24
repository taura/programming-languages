# <font color="green">Tail Recursive Calls</font>

- Investigate what happens with _tail_ recursive calls.
- Define a function `sum_array_tail` (or `SumArrayTail` in Go) that takes an array $a$, two integers $i$ and $n$, and a floating-point accumulator $s$, and returns:

$$s + a[i] + a[i+1] + \cdots + a[n-1]$$ in Go/OCaml/Rust and

$$s + a[i+1] + a[i+2] + \cdots + a[n]$$ in Julia

Write it in a **tail-recursive** style.

## Problems

Make a note of the following:

1. Does the compiler successfully eliminate stack growth (i.e., does it perform tail-call optimization)?

