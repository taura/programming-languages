# <font color="green">Fast Power</font>

1. Write a function `power_simple` (or `powerSimple`, depending on the naming convention of your language) that takes:
   - a 64-bit floating point number $a$
   - a non-negative integer $n$ ($n \ge 0$)
and returns $a^n$ using recursion as straightforwardly as possible
   * Hint: just observe the straightforward recurrence: $a^0 = 1$, and $a^n = a \cdot a^{n-1}$ for $n > 0$
   * Note 1: do not use loops or mutable variables. A loop-based version, `power_iter` (or `powerIter`), is provided in the boilerplate code for comparison
   * Note 2: `power_simple` may cause a stack overflow for large $n$ due to deep recursion, but that is OK for this problem (you will fix it in a later topic, **tail\_recursion**)

2. Write a faster version, `power_fast` (or `powerFast`, depending on the naming convention of your language), that computes $a^n$ using _<font color=blue>only $O(\log n)$ multiplications</font>_
   * Hint: observe that $a^{100} = a^{50} \times a^{50}$, or more generally, $a^{2n} = a^n \times a^n$
   * An alternative observation is $a^{100} = (a^2)^{50}$, which leads to a slightly different implementation. Try both if you can
   * `power_fast` is one of the simplest examples where a recursion demonstrates a clear practical advantage over a loop. The observation above is straightforward to express with recursion, but awkward with loops
   * As a bonus, `power_fast` will not cause a stack overflow even for very large $n$, since the recursion depth is also $O(\log n)$
   * Note 3: since $a^n$ rapidly grows to infinity when $|a| > 1$ and rapidly shrinks to zero when $|a| < 1$, computing $a^n$ for very large $n$ is rarely meaningful in practice. The purpose of this problem to illustrate the core idea with a simple example
   * Note 4: if $a$ is just a scalar, the two versions may not differ much in speed, since each multiplication is cheap
   * For these reasons, the idea behind `power_fast` really shines when, for example:
     - $a$ is a large matrix, where each multiplication is expensive
     - $a$ is a bignum (arbitrary-precision integer)
     - we use modular arithmetic, which avoids arithmetic overflow

* Boilerplate source files `{go,jl,ml,rs}/fast_power.{go,jl,ml,rs}` containing the test code is generated and shown below.

* Edit the source files either by opening them in a text editor (e.g., vscode), or editing the cells below and executing them.

