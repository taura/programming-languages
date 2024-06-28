typedef struct {
  long x;
  long y;
  long z;
} point;

point mk_point(long x, long y, long z);

long get_point() {
  point p = mk_point(1, 2, 3);
  return p.x + p.y + p.z;
}

