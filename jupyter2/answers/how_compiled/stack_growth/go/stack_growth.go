package how_compiled

func SumArrayRec(a []float64, n int64) float64 {
	if (n == 0) {
		return 0.0
	} else {
		return SumArrayRec(a, n - 1) + a[n]
	}
}
