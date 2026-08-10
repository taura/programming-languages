#include <stdio.h>
#include <stdlib.h>
#include <time.h>
/*** if label in ["show_addr", "measure_time" ] */
#include <gc/gc.h>
/*** endif */

/*** if label == "measure_time" */
long time_ns() {
  struct timespec ts[1];
  clock_gettime(CLOCK_REALTIME, ts);
  return ts->tv_sec * 1000000000L + ts->tv_nsec;
}
/*** endif */

typedef long T;

int main(int argc, char ** argv) {
  long s = (1 < argc ? atol(argv[1]) : 1000 * 1000);
  long m = (2 < argc ? atol(argv[2]) : 100);
  long n = (3 < argc ? atol(argv[3]) : m * 10);
/*** if label in [ "alloc_arrays", "show_addr_no_gc" ] */
  if (sizeof(T) * s * n > (1L << 31)) {
      fprintf(stderr, "you'd better not allocate that much memory\n");
      fprintf(stderr, "sizeof element(8) * s(%ld) * n(%ld) > 2GB\n", s, n);
      exit(1);
  }
/*** endif */
/*** if label in [ "show_addr", "measure_time" ] */
  if (sizeof(T) * s * m > (1L << 30)) {
      fprintf(stderr, "you'd better not allocate that much memory\n");
      fprintf(stderr, "sizeof(T)(8) * s(%ld) * m(%ld) > 1GB\n", s, m);
      exit(1);
  }
/*** endif */
/*** if label in [ "alloc_arrays", "show_addr_no_gc" ] */
  T ** a = (T **)malloc(sizeof(T *) * m);
/*** endif */
/*** if label in [ "show_addr", "measure_time" ] */
  T ** a = (T **)GC_MALLOC(sizeof(T *) * m);
/*** endif */
  for (long i = 0; i < n; i++) {
/*** if label == "measure_time" */
    long t0 = time_ns();
/*** endif */
/*** if label in [ "alloc_arrays", "show_addr_no_gc" ] */
    T * b = (T *)malloc(sizeof(T) * s);
/*** endif */
/*** if label in [ "show_addr", "measure_time" ] */
    T * b = (T *)GC_MALLOC_ATOMIC(sizeof(T) * s);
/*** endif */
    a[i % m] = b;
/*** if label == "measure_time" */
    long t1 = time_ns();
/*** endif */
/*** if label in [ "show_addr", "show_addr_no_gc" ] */
    printf("%ld\t%ld\n", i, (long)&b[0]);
/*** endif */
/*** if label == "measure_time" */
    printf("%ld\t%ld\t%ld\n", i, (long)&b[0], t1 - t0);
/*** endif */
  }
  return 0;
}

