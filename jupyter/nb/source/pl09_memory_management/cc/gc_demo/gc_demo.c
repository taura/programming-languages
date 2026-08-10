#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <gc/gc.h>

long time_ns() {
  struct timespec ts[1];
  clock_gettime(CLOCK_REALTIME, ts);
  return ts->tv_sec * 1000000000L + ts->tv_nsec;
}

int main(int argc, char ** argv) {
  long s = (1 < argc ? atol(argv[1]) : 1000 * 1000);
  long m = (2 < argc ? atol(argv[2]) : 10);
  long n = (3 < argc ? atol(argv[3]) : m * 10);
  if (sizeof(double) * s * n > (1L << 31)) {
      fprintf(stderr, "you'd better not allocate that much memory\n");
      fprintf(stderr, "sizeof(double)(8) * s(%ld) * n(%ld) < 2GB\n", s, n);
      exit(1);
  }
  double ** a = (double **)GC_MALLOC(sizeof(double *) * m);
  for (long i = 0; i < n; i++) {
    long t0 = time_ns();
    double * b = (double *)GC_MALLOC(sizeof(double) * s);
    a[i % m] = b;
    long t1 = time_ns();
    printf("%ld %ld %ld\n", i, (long)&b[0], t1 - t0);
  }
  return 0;
}

