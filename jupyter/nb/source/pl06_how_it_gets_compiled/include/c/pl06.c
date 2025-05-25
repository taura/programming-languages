/*** if label == "many_args" */
long many_args(long a00, long a01, long a02, long a03, long a04, long a05,
               long a06, long a07, long a08, long a09, long a10, long a11) {
  return a00 + a01 + a02 + a03 + a04 + a05 + a06 + a07 + a08 + a09 + a10 + a11;
}
/*** endif */
/*** if label == "add_floats" */
double add_floats(double x, double y) {
  return x + y;
}
/*** endif */
/*** if label == "get_float_array_elem" */
double get_float_array_elem_const(double a[10]) {
  return a[2];
}
double get_float_array_elem_i(double a[10], long i) {
  return a[i];
}
/*** endif */
/*** if label == "get_struct_elem" */
typedef struct {
  double x;
  double y;
} point;
double get_point_y(point p) {
  return p.y;
}
double get_pointp_y(point * p) {
  return p->y;
}
/*** endif */
/*** if label == "collatz" */
long collatz(long n) {
  if (n % 2 == 0) {
    return n / 2;
  } else {
    return 3 * n + 1;
  }
}
/*** endif */
/*** if label == "call_tanh" */
#include <math.h>
double call_tanh(double x) {
  return tanh(x + 1.0) + x;
}
/*** endif */
/*** if label == "regions" */
long regions(long n) {
  if (n == 0) {
    return 1;
  } else {
    return regions(n - 1) + n - 1;
  }
}
/*** endif */
/*** if label == "sum_array_rec" */
double sum_array_rec(double * a, long p, long q) {
  if (q - p == 0) {
    return 0.0;
  } else if (q - p == 1) {
    return a[p];
  } else {
    long r = (p + q) / 2;
    return sum_array_rec(a, p, r) + sum_array_rec(a, r, q);
  }
}
/*** endif */
/*** if label == "regions_tail" */
long regions_tail(long i, long n, long ri) {
  if (i == n) {
    return ri;
  } else {
    long riplus1 = ri + i + 1;
    return regions_tail(i + 1, n, riplus1);
  }
}
/*** endif */
/*** if label == "sum_array_tail_rec" */
double sum_array_tail_rec(double * a, long i, long n, double s) {
  if (i == n) {
    return s;
  } else {
    return sum_array_tail_rec(a, i + 1, n, s + a[i]);
  }
}
/*** endif */
/*** if label == "sum_array_loop" */
double sum_array_loop(double * a, long n) {
  double s = 0.0;
  for (int i = 0; i < n; i++) {
    s += a[i];
  }
  return s;
}
/*** endif */
