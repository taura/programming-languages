long gg(long);
long ff() {
  long a0 = gg(0);
  long a1 = gg(1);
  long a2 = gg(2);
  long a3 = gg(3);
  long a4 = gg(4);
  long a5 = gg(5);
  long a6 = gg(6);
  long a7 = gg(7);
  long a8 = gg(8);
  long a9 = gg(9);
  long x = gg(10);
  if (x < 0) return a0;
  if (x < 1) return a1;
  if (x < 2) return a2;
  if (x < 3) return a3;
  if (x < 4) return a4;
  if (x < 5) return a5;
  if (x < 6) return a6;
  if (x < 7) return a7;
  if (x < 8) return a8;
  return a9;
}
