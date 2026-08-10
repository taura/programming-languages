#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
long add_or_mul_long(long x, long y, long z);
int main(int argc, char ** argv) {
  assert(argc == 4);
  long x = atol(argv[1]);
  long y = atol(argv[2]);
  long z = atol(argv[3]);
  long r = add_or_mul_long(x, y, z);
  long rc = (x < y) ? (y + z) : (y * z);
  if (r == rc) { printf("OK %ld %ld\n", r, rc); return 0; }
  else { printf("NG %ld %ld\n", r, rc); return 1; }
}
