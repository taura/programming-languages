#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
double ax_by_cz_double(double a, double x, double b, double y, double c, double z);

int main(int argc, char ** argv) {
  assert(argc == 7);
  double a = atof(argv[1]);
  double x = atof(argv[2]);
  double b = atof(argv[3]);
  double y = atof(argv[4]);
  double c = atof(argv[5]);
  double z = atof(argv[6]);
  double r = ax_by_cz_double(a, x, b, y, c, z);
  double rc = a * x + b * y + c * z;
  if (fabs(r - rc) <= 1e-9 * (1.0 + fabs(rc))) {
    printf("OK %f %f\n", r, rc);
    return 0;
  } else {
    printf("NG %f %f\n", r, rc);
    return 1;
  }
}
