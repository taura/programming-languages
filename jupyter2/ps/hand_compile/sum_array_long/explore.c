/* A loop compiled into compare + conditional branch.
   Observe the loop body, the increment, the cmp, and the branch back to the top. */
long fact(long n) {
  long i = 1;
  long p = 1;
  while (i <= n) {
    p = p * i;
    i = i + 1;
  }
  return p;
}
