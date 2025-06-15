#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
double normal(double x);

double normal_c(double x) {
  return exp(- x * x * 0.5) / sqrt(8.0 * atan2(1.0, 1.0));
}

int main(int argc, char ** argv) {
  long x = atof(argv[1]);
  long y = normal(x);
  long yc = normal_c(x);
  assert(fabs(y - yc) < 1.0e-6);
  printf("OK\n");
  return 0;
}
