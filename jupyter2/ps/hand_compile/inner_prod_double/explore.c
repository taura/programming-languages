/* A loop that accumulates over one array: load a[i] and add it to a running
   sum. Observe the load, the fadd into the accumulator, and the loop back-edge.
   The problem extends this to TWO arrays, multiplying p[i]*q[i] before adding. */
double sum_one(double * a, long n) {
  double s = 0.0;
  for (long i = 0; i < n; i++) s += a[i];
  return s;
}
