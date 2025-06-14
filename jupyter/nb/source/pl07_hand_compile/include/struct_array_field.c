typedef struct {
  long x;
  long y;
  long z;
} point;
  
long struct_array_field(point * p) {
  return p[10].x + p[10].y + p[10].z;
}
