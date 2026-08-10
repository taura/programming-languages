package how_compiled

func SumArrayTail(a []float64, i int64, n int64, s float64) float64 {
	if i == n {
		return s
	} else {
		return SumArrayTail(a, i + 1, n, s + a[i])
	}
}
