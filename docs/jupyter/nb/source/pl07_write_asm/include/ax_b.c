double ax_b(double x0, double a, double b, long n) {
  double x = x0;
  for (long i = 0; i < n; i++) {
    x = a * x + b;
  }
  return x;
}
