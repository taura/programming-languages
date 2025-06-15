double max_array(double * a, long n) {
  double m = 0.0;
  for (long i = 0; i < n; i++) {
    if (a[i] > m) m = a[i];
  }
  return m;
}
