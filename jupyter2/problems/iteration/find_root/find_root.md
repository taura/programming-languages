# <font color="green">Root Finding by Binary Search</font>

* Consider the function

$$
f(x) = x^3 - x - 2.
$$

* Write a function `find_root` (or `findRoot` depending on the language's case convention) that takes:
  - 64-bit floating point numbers \(a\) and \(b\) with \(f(a)\) and \(f(b)\) having opposite signs,
  - 64-bit floating point number \(\epsilon\),

  and returns an approximation of a root of \(f(x)=0\) using binary search.

* At each step:
  - compute the midpoint \(m = (a+b)/2\),
  - if \(f(m)\) has the same sign as \(f(a)\), replace \(a\) with \(m\),
  - otherwise replace \(b\) with \(m\).

* when it becomes \(|b-a|<\epsilon\), return the midpoint.

* Use:
  - 64-bit floating point numbers for all real values

* Boilerplate source files `{go,jl,ml,rs}/find_root.{go,jl,ml,rs}` containing the test code is generated and shown below.

* Edit the source files either by opening them in a text editor (e.g., vscode), or editing the cells below and executing them.
