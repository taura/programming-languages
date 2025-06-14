#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
long mul_3_add_5(long);

int main(int argc, char ** argv) {
  long x = atol(argv[1]);
  long y = mul_3_add_5(x);
  assert(y == 3 * x + 5);
  printf("OK\n");
  return 0;
}
