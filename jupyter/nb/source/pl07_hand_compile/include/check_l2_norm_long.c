#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
long l2_norm_long(long *);

int main(int argc, char ** argv) {
  assert(argc == 4);
  long x[3] = { atol(argv[1]), atol(argv[2]), atol(argv[3]) };
  long l2 = l2_norm_long(x);
  assert(l2 == x[0] * x[0] + x[1] * x[1] + x[2] * x[2]);
  printf("OK %ld\n", l2);
  return 0;
}
