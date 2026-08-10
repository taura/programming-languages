#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
double inner_prod_double(double * p, double * q, long n);

int main(int argc, char ** argv) {
  long n = (argc >= 2) ? atol(argv[1]) : 1000;
  double * p = (double *) malloc(n * sizeof(double));
  double * q = (double *) malloc(n * sizeof(double));
  for (long i = 0; i < n; i++) { p[i] = (double)((i % 7) + 1) * 0.5; q[i] = (double)((i % 5) + 1); }

  double r = inner_prod_double(p, q, n);
  double rc = 0.0;
  for (long i = 0; i < n; i++) rc += p[i] * q[i];

  if (fabs(r - rc) <= 1e-9 * (1.0 + fabs(rc))) { printf("OK %f %f\n", r, rc); free(p); free(q); return 0; }
  else { printf("NG %f %f\n", r, rc); free(p); free(q); return 1; }
}
