typedef struct {
  long x;
  long y;
  long z;
} point;
  
long struct_field(point * p) {
  return p->x + p->y + p->z;
}
