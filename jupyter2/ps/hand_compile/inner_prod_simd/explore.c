/* A floating-point dot product. The compiler keeps the additions as a SERIAL
   chain of fmadd/fadd into a single accumulator (a loop-carried dependency):
   even if it uses vector LOADS, it does NOT add the lanes in parallel, because
   reordering floating-point additions would change the rounding of the result. */
double inner_prod_scalar(double * p, double * q, long n) {
  double s = 0.0;
  for (long i = 0; i < n; i++) s += p[i] * q[i];
  return s;
}

/* For contrast: this loop HAS no loop-carried fp dependency (each c[i] is
   independent), so the compiler WILL auto-vectorize it with v-registers. */
void vmul(double * p, double * q, double * c, long n) {
  for (long i = 0; i < n; i++) c[i] = p[i] * q[i];
}
