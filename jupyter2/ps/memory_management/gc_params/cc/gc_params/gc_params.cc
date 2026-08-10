#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char ** argv) {
  long s = (1 < argc ? atol(argv[1]) : 1000 * 1000);
  long m = (2 < argc ? atol(argv[2]) : 10);
  long n = (3 < argc ? atol(argv[3]) : m * 10);
  if (sizeof(long) * s * n > (1L << 32)) {
      fprintf(stderr, "you'd better not allocate that much memory\n");
      fprintf(stderr, "sizeof(long)(8) * s(%ld) * n(%ld) < 4GB\n", s, n);
      exit(1);
  }
  volatile long ** a = (volatile long **)malloc(sizeof(long *) * m);
  for (long i = 0; i < n; i++) {
    volatile long * b = (long *)malloc(sizeof(long) * s);
    for (long j = 0; j < s; j++) b[j] = i;
    a[i % m] = b;
  }
  printf("a[0][0] = %ld\n", a[0][0]);
  return 0;
}

