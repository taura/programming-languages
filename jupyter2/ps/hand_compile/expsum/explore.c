/* When a function calls another function, it must set up a stack frame
   (save x29/x30) before the call. Observe the stp/ldp and bl instructions. */
#include <math.h>
double sigmoid(double x) { return 1.0 / (1.0 + exp(-x)); }
