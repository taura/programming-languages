/* Floating-point arithmetic: observe fadd / fsub / fmul and the d0,d1,... ABI. */
double fadd(double x, double y, double z) { return x + y + z; }
double fsub(double x, double y, double z) { return x - y - z; }
double fmul(double x, double y, double z) { return x * y * z; }
