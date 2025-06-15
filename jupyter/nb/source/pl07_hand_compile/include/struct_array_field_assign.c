typedef struct {
  long x;
  long y;
  long z;
} point;
  
void struct_array_field(point * p) {
  p[10].x = 30;
  p[10].z = 50;
}
