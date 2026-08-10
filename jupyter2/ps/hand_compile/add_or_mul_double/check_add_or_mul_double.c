#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
double add_or_mul_double(double x, double y, double z);

int main(int argc, char ** argv) {
  assert(argc == 4);
  double x = atof(argv[1]);
  double y = atof(argv[2]);
  double z = atof(argv[3]);
  double r = add_or_mul_double(x, y, z);
  double rc = (x < y) ? (y + z) : (y * z);
  if (fabs(r - rc) <= 1e-9 * (1.0 + fabs(rc))) { printf("OK %f %f\n", r, rc); return 0; }
  else { printf("NG %f %f\n", r, rc); return 1; }
}
