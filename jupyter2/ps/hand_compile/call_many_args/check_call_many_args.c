#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
long call_many_args(long base);

/* the function your code must call (sum of its 20 arguments) */
long add_many(long a00, long a01, long a02, long a03, long a04, long a05, long a06, long a07, long a08, long a09, long a10, long a11, long a12, long a13, long a14, long a15, long a16, long a17, long a18, long a19) {
  return a00 + a01 + a02 + a03 + a04 + a05 + a06 + a07 + a08 + a09 + a10 + a11 + a12 + a13 + a14 + a15 + a16 + a17 + a18 + a19;
}

int main(int argc, char ** argv) {
  assert(argc == 2);
  long base = atol(argv[1]);
  long r = call_many_args(base);
  long rc = 0;
  for (int i = 0; i < 20; i++) rc += base + i;   /* add_many(base, base+1, ..., base+19) */
  if (r == rc) { printf("OK %ld %ld\n", r, rc); return 0; }
  else { printf("NG %ld %ld\n", r, rc); return 1; }
}
