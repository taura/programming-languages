/* Allocating memory with malloc and storing into it.
   Note: the incoming arguments (a, b, c in x0, x1, x2) must be saved across
   the call to malloc, because malloc returns its result in x0 and is free to
   clobber the argument registers. */
void * malloc(unsigned long n);
long * make3(long a, long b, long c) {
  long * x = (long *) malloc(3 * sizeof(long));
  x[0] = a; x[1] = b; x[2] = c;
  return x;
}
