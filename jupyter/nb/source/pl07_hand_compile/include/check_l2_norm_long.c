#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
long l2_norm_long(long *);

int main(int argc, char ** argv) {
  assert(argc == 4);
  long x[3] = { atol(argv[1]), atol(argv[2]), atol(argv[3]) };
  long l2 = l2_norm_long(x);
  long l2c = x[0] * x[0] + x[1] * x[1] + x[2] * x[2];
  if (l2 == l2c) {
    printf("OK %ld %ld\n", l2, l2c);
    return 0;
  } else {
    printf("NG %ld %ld\n", l2, l2c);
    return 1;
  }
}
