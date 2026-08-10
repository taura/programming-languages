/* These compile to a conditional BRANCH (not a conditional select), because
   only ONE side may safely run --- the compiler must NOT execute both. */

/* It cannot compute x % y speculatively: dividing by zero is undefined,
   so the modulo must stay guarded behind the y != 0 test. */
long mod_or_one(long x, long y) {
  if (y != 0) { return x % y; } else { return 1; }
}

/* It cannot call sink() speculatively: a call may have side effects. */
extern long sink(long x);
long call_or_zero(long x, long c) {
  if (c) { return sink(x); } else { return 0; }
}
