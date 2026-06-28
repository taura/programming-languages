# <font color="green">Conditional branch (dereference or zero)</font>

## Problem

* Write a function `deref_or_zero(p)` __in assembly__ that returns `*p` if `p` is non-null, and `0` otherwise.
* The point of this problem is that you **must** use a conditional branch: you cannot load `*p` before checking `p`, because loading from a null pointer would crash.
* That is, translate the following C function into assembly:
```
long deref_or_zero(long * p) {
  if (p) { return *p; } else { return 0; }
}
```
* Compare `p` against `0`, branch to a "return 0" path when it is null, and otherwise load `*p` and return it.
* Fill in the skeleton `deref_or_zero.s` (after `// ------- write your answer here -------`).
* The checker `check_deref_or_zero.c` calls your function with both a valid pointer and a null pointer. If you see `OK`s and no errors, you are done.

## Hints

* In the *Conditional select* problem, the compiler avoided a branch by computing **both** results and selecting one with `csel`. That works only when both sides are always safe and cheap to compute.
* Sometimes that is impossible: only **one** side may be executed. Then the compiler has no choice but to emit a real conditional branch. Typical reasons:
  * executing the wrong side would be **unsafe** --- e.g. dereferencing a pointer that may be null would crash;
  * a side has **side effects** or unknown cost --- e.g. it calls a function, so it cannot be run speculatively.
* The *Observe* cells below contain two such functions: `mod_or_one` (which must not compute `x % y` when `y` is `0`, since dividing by zero is undefined) and `call_or_zero` (which must not call a function speculatively). Compile them and confirm that, unlike `add_or_mul_long`, they really do produce a comparison followed by a conditional branch (e.g. `cbz`/`cbnz` or `cmp` + `b.<cond>`) --- the compiler does **not** compute both sides.
