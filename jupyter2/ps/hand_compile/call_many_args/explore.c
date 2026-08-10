/* Calling a function with more than eight arguments: the first eight go in
   x0..x7, and the rest must be written to the STACK at [sp], [sp,#8], ...
   before the 'bl'. This simple example calls a 10-parameter function, so only
   the 9th and 10th arguments are passed on the stack. Observe how the caller
   reserves stack space and stores those two before the call. */
long add10(long, long, long, long, long, long, long, long, long, long);
long call_add10(void) {
  return add10(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
}
