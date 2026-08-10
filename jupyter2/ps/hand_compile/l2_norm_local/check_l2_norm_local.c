#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
long l2_norm_local(long a, long b, long c);

/* the opaque function your code calls */
long l2_norm_long(long * x) {
  return x[0] * x[0] + x[1] * x[1] + x[2] * x[2];
}

int main(int argc, char ** argv) {
  assert(argc == 4);
  long a = atol(argv[1]);
  long b = atol(argv[2]);
  long c = atol(argv[3]);
  long r = l2_norm_local(a, b, c);
  long rc = a * a + b * b + c * c;
  if (r == rc) { printf("OK %ld %ld\n", r, rc); return 0; }
  else { printf("NG %ld %ld\n", r, rc); return 1; }
}
