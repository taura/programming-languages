/* if-without-branch: the compiler evaluates a value for each side and picks one
   with a conditional-select (csel) --- no branch at all. Observe `cmp` followed
   by `csel`. (Here the two candidates are simply `a` and `b`.) */
long imax(long a, long b) {
  return a > b ? a : b;
}
