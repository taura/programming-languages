long add_or_mul_long(long x, long y, long z) {
  if (x < y) {
    return y + z;
  } else {
    return y * z;
  }
}
