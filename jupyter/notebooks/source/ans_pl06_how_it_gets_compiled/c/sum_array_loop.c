
double sum_array_loop(double * a, long n) {
  double s = 0.0;
  for (int i = 0; i < n; i++) {
    s += a[i];
  }
  return s;
}
