typedef struct {
  long x;
  long y;
  long z;
} point;

point mk_point(long x, long y, long z) {
  point p = { x, y, z };
  return p;
}

