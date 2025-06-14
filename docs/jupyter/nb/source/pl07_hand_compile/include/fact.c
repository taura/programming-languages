long fact (long n) {
  long i = 1;
  long p = 1;
  while (i <= n) {
    p = p * i;
    i = i + 1;
  }
  return p;
}
