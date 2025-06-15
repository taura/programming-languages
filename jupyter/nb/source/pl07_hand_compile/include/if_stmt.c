long f(long);
long g(long x) {
  if (x < 1) {
    return x + 123;
  } else {
    return f(456);
  }
}
