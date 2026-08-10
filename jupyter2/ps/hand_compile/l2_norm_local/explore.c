/* A local (stack) array whose address is passed to another function.
   Observe: stack space reserved with `sub sp, sp, #..`; the address of the
   local formed from sp (`mov x0, sp` or `add x0, sp, #off`); the values stored
   into the array before the call; and the stack released afterwards. */
long use_pair(long * p);   /* some opaque function that reads p[0], p[1] */
long demo_local(long a, long b) {
  long t[2];
  t[0] = a;
  t[1] = b;
  return use_pair(t);
}
