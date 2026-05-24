package how_compiled

func SumArrayLoop(a []float64, n int64) float64 {
	s := 0.0
	var i int64;
	for i = 0; i < n; i++ {
		s += a[i]
	}
	return s;
}
