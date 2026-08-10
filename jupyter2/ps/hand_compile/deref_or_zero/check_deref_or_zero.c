#include <stdio.h>
long deref_or_zero(long * p);

int main(void) {
  long v = 42;
  long r1 = deref_or_zero(&v);
  long r2 = deref_or_zero((long *) 0);
  int ok = 1;
  if (r1 == 42) printf("OK deref %ld\n", r1);
  else { printf("NG deref %ld (expected 42)\n", r1); ok = 0; }
  if (r2 == 0) printf("OK null %ld\n", r2);
  else { printf("NG null %ld (expected 0)\n", r2); ok = 0; }
  return ok ? 0 : 1;
}
