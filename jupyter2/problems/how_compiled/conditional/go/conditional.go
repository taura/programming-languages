package how_compiled
func Gcd1(a int64, b int64) int64 {
	if b == 0 {
		return a
	} else {
		return a % b
	}
}
