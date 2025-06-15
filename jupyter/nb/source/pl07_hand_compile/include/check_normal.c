#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
double normal(double x);

double normal_c(double x) {
  return exp(- x * x * 0.5) / sqrt(8.0 * atan2(1.0, 1.0));
}

int main(int argc, char ** argv) {
  assert(argc == 2);
  double x = atof(argv[1]);
  double y = normal(x);
  double yc = normal_c(x);
  if (fabs(y - yc) < 1.0e-6) {
    printf("OK %f %f\n", y, yc);
  } else {
    printf("NG %f %f\n", y, yc);
  }
  return 0;
}
