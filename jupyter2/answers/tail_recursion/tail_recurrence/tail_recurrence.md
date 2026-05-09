# <font color="green">Tail Recursive Recurrence</font>

* Let's revisit the affine recurrence problem we worked in an earlier topic of recursion

$$
x_0 = c, \qquad x_n = a x_{n-1} + b
$$

1. Write a function `affine_recurrence_simple_tail` (or `affineRecurrenceSimpleTail`) that takes:
  - 64-bit floating point numbers $a$, $b$, and $c$,
  - and an integer $n$ (you may assume $n \ge 0$),
and returns $x_n$.

* Hint: you need to introduce an auxiliary function that takes an extra parameter $m$ ($\le n$) and $x_m$
  * the auxiliary function returns $x_n$ _given $m$ and $x_m$_
  * that is,
    * if $m = n$ just return $x_m$, which is given
    * otherwise, compute $x_{m+1} = a x_m + b$ and obtain $x_n$ by recursive call

* Note: `affine_recurrence_simple_tail` takes $O(n)$ time, but should not cause stack overflow even for large $n$

2. Apply the same idea to get a tail recursive version of `affine_recurrence_fast` (or `affineRecurrenceFast`).  Define it as `affine_recurrence_fast_tail` (`affineRecurrenceFastTail`)

* Note: the tail recursive version of `affine_recurrence_fast` is not compelling and purely for practice, because it has practically no risk for stack overflow

* Boilerplate source files `{go,jl,ml,rs}/tail_recurrence.{go,jl,ml,rs}` containing the test code is generated and shown below.

* Edit the source files either by opening them in a text editor (e.g., vscode), or editing the cells below and executing them.
