#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
long sum_array(long *, long);

long sum_array_c(long * a, long n) {
  long s = 0;
  for (long i = 0; i < n; i++) {
    s += a[i];
  }
  return s;
}

int main(int argc, char ** argv) {
  long n = argc - 1;
  long * a = (long *)malloc(sizeof(long) * n);
  for (long i = 0; i < n; i++) {
    a[i] = atol(argv[i + 1]);
  }
  long sa = sum_array(a, n);
  assert(sa == sum_array_c(a, n));
  printf("OK\n");
  return 0;
}
