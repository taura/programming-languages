#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
long many_args(long a00, long a01, long a02, long a03, long a04, long a05, long a06, long a07, long a08, long a09, long a10, long a11, long a12, long a13, long a14, long a15, long a16, long a17, long a18, long a19);

int main(int argc, char ** argv) {
  assert(argc == 21);
  long a[20];
  for (int i = 0; i < 20; i++) a[i] = atol(argv[i + 1]);
  long r = many_args(a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9],
                      a[10], a[11], a[12], a[13], a[14], a[15], a[16], a[17], a[18], a[19]);
  long rc = a[8] * 1000 + a[15];   /* a08 * 1000 + a15 */
  if (r == rc) { printf("OK %ld %ld\n", r, rc); return 0; }
  else { printf("NG %ld %ld\n", r, rc); return 1; }
}
