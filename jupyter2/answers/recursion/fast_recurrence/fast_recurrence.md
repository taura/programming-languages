# <font color="green">Fast Affine Recurrence</font>
* Consider the sequence defined by:
$$
x_0 = c, \qquad x_n = a x_{n-1} + b
$$

1. Write a function `affine_recurrence_simple` (or `affineRecurrenceSimple`, depending on the naming convention of your language) that takes:
   - 64-bit floating point numbers $a$, $b$, and $c$,
   - a non-negative integer $n$ ($n \ge 0$),
   - and returns $x_n$
   * Note 1: do not use loops or mutable variables. A loop-based version, `affine_recurrence_iter` (or `affineRecurrenceIter`), is provided in the boilerplate code for comparison
   * Note 2: `affine_recurrence_simple` may cause a stack overflow for large $n$ due to deep recursion, but that is acceptable for this problem (you will fix it in a later topic, **tail\_recursion**)

2. Write a faster version, `affine_recurrence_fast` (or `affineRecurrenceFast`, depending on the naming convention of your language), that computes $x_n$ in _only $O(\log n)$ time_
   * Hint: this is a generalization of the previous fast power problem
   * Observe:
$$x_n = a x_{n-1} + b = a(a x_{n-2} + b) + b = a^2 x_{n-2} + ab + b$$
   * Therefore, if we define $y_n$ as:
$$
y_0 = c, \qquad y_n = a^2 y_{n-1} + ab + b
$$
then $x_{100} = y_{50}$, or more generally, $x_{2n} = y_n$
   * Apply this idea recursively
	 
* Boilerplate source files `{go,jl,ml,rs}/fast_recurrence.{go,jl,ml,rs}` containing the test code is generated and shown below.

* Edit the source files either by opening them in a text editor (e.g., vscode), or editing the cells below and executing them.
