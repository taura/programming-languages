/* Comparing two floating-point numbers uses fcmp / fcmpe (not the integer cmp).
   This simple example returns 1.0 if a > b, else -1.0. Observe fcmpe followed by
   a conditional select (fcsel) choosing between the two candidate results.
   (A plain max would fold into a single fmaxnm, hiding the comparison, so this
   example returns two distinct constants instead.) */
double cmp_sign(double a, double b) {
  return a > b ? 1.0 : -1.0;
}
