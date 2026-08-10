# <font color="green">An Optimizer for Float → Float Functions</font>

* Define a function `optimize` that takes a function $f : \mathbb{R} \to \mathbb{R}$ and a range $[a, b]$ and computes an approximation of $\min_{x \in [a,b]} f(x)$.
* Since any non-empty interval contains infinitely many points, we approximate by sampling $n$ evenly spaced points from the range, evaluating $f$ at each, and returning the minimum.
* Specifically, evaluate $f(x)$ at $x = a,\ a+\Delta,\ a+2\Delta,\ \ldots,\ a+(n-1)\Delta$, where $\Delta = (b-a)/(n-1)$.
* We wish to write this in a way that can later be extended to functions taking other input types.
* To that end, define a type representing a range and a constructor $\texttt{arange}(a, b, n)$.
  * This range object supports a `next` method that, when called repeatedly, returns the above $n$ points on the first $n$ calls and a sentinel value indicating exhaustion thereafter.
* Using this range object, a schematic implementation of the optimizer is:

```python
def optimize(f, rng):
    x = rng.next()
    while x != no-more-values:
        y = f(x)
        x = rng.next()
    return the minimum y seen in the loop
```

* If the very first call to `rng.next()` returns the sentinel value (i.e., `rng` is empty), `optimize` itself should signal the absence of a minimum, using:
  * multiple return values in Go (a `bool` together with a floating-point number)
  * `nothing` in Julia
  * `option` in OCaml
  * `Option` in Rust
* Refer to the test code and make your implementation conform to it.
* As written, this optimizer is already fairly generic — it handles any function from `float` to `float` — but a straightforward implementation may unnecessarily restrict $x$ to floating-point numbers.
* In fact, the logic above should work for any input type of $f$; making this fully generic is the goal of the next problem.
* Boilerplate source files `{go,jl,ml,rs}/optimize_float.{go,jl,ml,rs}` containing test code are generated and shown below.
* Edit the source files by opening them in a text editor (e.g., VS Code) or by editing and executing the cells below.


