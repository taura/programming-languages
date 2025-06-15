#include <math.h>
double normal_dist(double x) {
  return exp(- x * x * 0.5) / sqrt(8.0 * atan2(1.0, 1.0));
}
