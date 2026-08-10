#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

double inner_prod_simd(double * p, double * q, long n);

/* scalar reference: a plain serial dot product (the compiler keeps it scalar). */
static double inner_prod_ref(double * p, double * q, long n) {
  double s = 0.0;
  for (long i = 0; i < n; i++) s += p[i] * q[i];
  return s;
}

int main(int argc, char ** argv) {
  long n = (argc >= 2) ? atol(argv[1]) : 1000000;
  double * p = (double *) malloc(n * sizeof(double));
  double * q = (double *) malloc(n * sizeof(double));
  for (long i = 0; i < n; i++) { p[i] = (double)((i % 100) + 1) * 0.5; q[i] = (double)((i % 13) + 1); }

  double r  = inner_prod_simd(p, q, n);
  double rc = inner_prod_ref(p, q, n);

  /* reordering the additions changes the rounding slightly, so allow a tolerance */
  double tol = 1e-6 * (1.0 + fabs(rc));
  int ok = (fabs(r - rc) <= tol);
  printf("%s dot: yours=%.6f ref=%.6f (|diff|=%.3g, tol=%.3g)\n",
         ok ? "OK" : "NG", r, rc, fabs(r - rc), tol);

  /* informational timing only (not part of pass/fail) */
  int reps = 200;
  volatile double sink = 0.0;
  clock_t t0 = clock();
  for (int k = 0; k < reps; k++) { p[0] = (double) k; sink += inner_prod_ref(p, q, n); }
  clock_t t1 = clock();
  for (int k = 0; k < reps; k++) { p[0] = (double) k; sink += inner_prod_simd(p, q, n); }
  clock_t t2 = clock();
  double ts = (double)(t1 - t0) / CLOCKS_PER_SEC;
  double ty = (double)(t2 - t1) / CLOCKS_PER_SEC;
  printf("timing over %d reps (n=%ld): scalar=%.3f s, yours=%.3f s, speedup=%.2fx\n",
         reps, n, ts, ty, ts / (ty > 1e-9 ? ty : 1e-9));

  free(p); free(q);
  return ok ? 0 : 1;
}
