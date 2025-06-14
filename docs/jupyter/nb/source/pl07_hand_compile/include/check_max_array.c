#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
double max_array(double *, long);

double max_array_c(double * a, long n) {
  double m = 0.0;
  for (long i = 0; i < n; i++) {
    if (a[i] > m) m = a[i];
  }
  return m;
}

int main(int argc, char ** argv) {
  long n = argc - 1;
  double * a = (double *)malloc(sizeof(double) * n);
  for (long i = 0; i < n; i++) {
    a[i] = atof(argv[i + 1]);
  }
  double sa = max_array(a, n);
  assert(sa == max_array_c(a, n));
  printf("OK\n");
  return 0;
}
