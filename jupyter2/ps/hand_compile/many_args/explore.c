/* Receiving parameters that do not fit in registers. The ARM64 ABI passes the
   first eight integer arguments in x0..x7; the ninth and later arrive on the
   STACK, at [sp], [sp,#8], ... as seen on entry. This simple example reads the
   9th and 10th parameters (a8 at [sp], a9 at [sp,#8]) with ldr. */
long sum_last2(long a0, long a1, long a2, long a3, long a4,
               long a5, long a6, long a7, long a8, long a9) {
  return a8 + a9;
}
