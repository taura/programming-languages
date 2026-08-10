#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
double expsum(double x);

int main(int argc, char ** argv) {
  assert(argc == 2);
  double x = atof(argv[1]);
  double r = expsum(x);
  double rc = exp(x) + exp(-x);
  if (fabs(r - rc) <= 1e-9 * (1.0 + fabs(rc))) {
    printf("OK %f %f\n", r, rc);
    return 0;
  } else {
    printf("NG %f %f\n", r, rc);
    return 1;
  }
}
