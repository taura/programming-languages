
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
