# <font color="green">Loops with floating-point (max of a double array)</font>

## Problem

* Write a function `max_array(a, n)` that computes the maximum value of an `n`-element array of `double`s `a`, __in assembly__.
* You may assume all elements are positive and return `0` if there are no elements (`n == 0`).
* That is, translate the following C function into assembly:
```
double max_array(double * a, long n) {
  double m = 0.0;
  for (long i = 0; i < n; i++) {
    if (a[i] > m) m = a[i];
  }
  return m;
}
```
* Fill in the skeleton `max_array.s` (after `// ------- write your answer here -------`).
* The checker `check_max_array.c` verifies your result. If you see `OK`s and no errors, you are done.

## Hints

* This problem combines two things you have already seen:
  * a __loop__ over an array (as in the *Loops* problem), and
  * a __floating-point comparison__ (as in the *Floating-point comparison* problem, using `fcmp`/`fcmpe`).
* Recall that a `for` loop
```
for (init ; condition; increment) S;
```
is equivalent to
```
init;
while (condition) { S; increment; }
```
and a `while` loop becomes a comparison plus a conditional branch. Inside the loop body you compare each element against the current maximum with a floating-point compare.
* The *Observe* cells below show `dax_b`, a `for` loop over `double`s, so you can see how a floating-point loop looks in assembly.
