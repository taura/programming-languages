#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
long mul_3_add_5(long);

int main(int argc, char ** argv) {
  assert(argc == 2);
  long x = atol(argv[1]);
  long y = mul_3_add_5(x);
  long yc = 3 * x + 5;
  if (y == yc) {
    printf("OK %ld %ld\n", y, yc);
    return 0;
  } else {
    printf("NG %ld %ld\n", y, yc);
    return 1;
  }
}
