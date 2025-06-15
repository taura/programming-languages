#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
long ax_by_cz(long a, long x, long b, long y, long c, long z);

int main(int argc, char ** argv) {
  assert(argc == 7);
  long a = atol(argv[1]);
  long x = atol(argv[2]);
  long b = atol(argv[3]);
  long y = atol(argv[4]);
  long c = atol(argv[5]);
  long z = atol(argv[6]);
  long r = ax_by_cz(a, x, b, y, c, z);
  long rc = a * x + b * y + c * z;
  if (r == rc) {
    printf("OK %ld %ld\n", r, rc);
  } else {
    printf("NG %ld %ld\n", r, rc);
  }
  return 0;
}
