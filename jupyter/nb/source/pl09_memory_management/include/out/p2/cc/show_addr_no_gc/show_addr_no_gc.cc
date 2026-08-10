#include <stdio.h>
#include <stdlib.h>
#include <time.h>


typedef long T;

int main(int argc, char ** argv) {
  long s = (1 < argc ? atol(argv[1]) : 1000 * 1000);
  long m = (2 < argc ? atol(argv[2]) : 100);
  long n = (3 < argc ? atol(argv[3]) : m * 10);
  if (sizeof(T) * s * n > (1L << 31)) {
      fprintf(stderr, "you'd better not allocate that much memory\n");
      fprintf(stderr, "sizeof element(8) * s(%ld) * n(%ld) > 2GB\n", s, n);
      exit(1);
  }
  T ** a = (T **)malloc(sizeof(T *) * m);
  for (long i = 0; i < n; i++) {
    T * b = (T *)malloc(sizeof(T) * s);
    a[i % m] = b;
    printf("%ld\t%ld\n", i, (long)&b[0]);
  }
  return 0;
}

