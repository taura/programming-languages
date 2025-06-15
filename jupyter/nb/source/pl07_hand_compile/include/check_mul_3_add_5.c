#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
long mul_3_add_5(long);

int main(int argc, char ** argv) {
  assert(argc == 2);
  long x = atol(argv[1]);
  long y = mul_3_add_5(x);
  assert(y == 3 * x + 5);
  printf("OK %ld\n", y);
  return 0;
}
