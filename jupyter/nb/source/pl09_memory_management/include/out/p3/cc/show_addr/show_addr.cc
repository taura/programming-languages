#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <gc/gc.h>


typedef long T;

int main(int argc, char ** argv) {
  long s = (1 < argc ? atol(argv[1]) : 1000 * 1000);
  long m = (2 < argc ? atol(argv[2]) : 100);
  long n = (3 < argc ? atol(argv[3]) : m * 10);
  if (sizeof(T) * s * m > (1L << 30)) {
      fprintf(stderr, "you'd better not allocate that much memory\n");
      fprintf(stderr, "sizeof(T)(8) * s(%ld) * m(%ld) > 1GB\n", s, m);
      exit(1);
  }
  T ** a = (T **)GC_MALLOC(sizeof(T *) * m);
  for (long i = 0; i < n; i++) {
    T * b = (T *)GC_MALLOC_ATOMIC(sizeof(T) * s);
    a[i % m] = b;
    printf("%ld\t%ld\n", i, (long)&b[0]);
  }
  return 0;
}

