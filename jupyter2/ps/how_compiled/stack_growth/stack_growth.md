# <font color="green">How the Stack Grows</font>

- Investigate what happens to the stack during deep recursive calls.
- Define a recursive function `sum_array_rec` (or `SumArrayRec` in Go) that takes an array $a$ and an integer $n$ and computes:

$$\text{{sum}}(a, n) = \begin{{cases}} 0 & (n = 0) \\ \text{{sum}}(a,\, n-1) + a[n-1] & (n > 0) \end{{cases}}$$

In Julia, use 1-based indexing:

$$\text{{sum}}(a, n) = \begin{{cases}} 0 & (n = 0) \\ \text{{sum}}(a,\, n-1) + a[n] & (n > 0) \end{{cases}}$$

## Problems

Make a note of the following:

1. How much stack space is allocated per function call, and how is it allocated?
2. What values are saved there?

