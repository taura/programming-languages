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
  double ma = max_array(a, n);
  double ma_c = max_array_c(a, n);
  if (ma == ma_c) {
    printf("OK %f %f\n", ma, ma_c);
  } else {
    printf("NG %f %f\n", ma, ma_c);
  }
  return 0;
}
