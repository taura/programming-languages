# <font color="green">Continued Fraction Evaluation</font>

* Write a tail-recursive version of function `continued_fraction` (or `continuedFraction`) we worked on in an earlier topic of recursion and define it as `continued_fraction_tail` (or `continuedFractionTail`)
* It takes:
  - a 64-bit floating point number $a$, and
  - an integer $n$ (you may assume $n \ge 1$),
and returns the value of the following nested expression:

$$
\frac{1}{a + \frac{1}{a + \frac{1}{a + \cdots}}}
$$
where the expression contains $n$ occurrences of $a$.

* Boilerplate source files `{go,jl,ml,rs}/continued_fraction.{go,jl,ml,rs}` containing the test code is generated and shown below.

* Edit the source files either by opening them in a text editor (e.g., vscode), or editing the cells below and executing them.
