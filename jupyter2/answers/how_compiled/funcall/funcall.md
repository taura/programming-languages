# <font color="green">Function Calls</font>

- Investigate how a function call is compiled from the caller's perspective.
- To this end, define a function `call_tanh` (or `CallTanh` in Go) that takes a floating-point number $x$ and returns $\tanh(x + 1.0) + 2.0$.

## Problems

Make a note of the following:

1. Locate the instruction that calls `tanh` (or an equivalent function).
2. Since the function computes $\tanh(x + 1.0) + 2.0$, the value of `x` must be saved somewhere across the call. Determine how and where it is saved.

