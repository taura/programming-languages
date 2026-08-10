#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
double softmax(double *);

int main(int argc, char ** argv) {
  double x[2] = { atof(argv[1]), atof(argv[2]) };
  double sm = softmax(x[0], x[1]);
  assert(l2 == x[0] * x[0] + x[1] * x[1] + x[2] * x[2]);
  printf("OK\n");
  return 0;
}
