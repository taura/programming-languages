long gg(long *);
long hh(long *);
long ff() {
  long a[100];
  long x = gg(a);
  long y = hh(a);
  return x + y;
}
