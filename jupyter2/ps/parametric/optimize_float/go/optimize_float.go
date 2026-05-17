package main
import (
	"fmt"
	"math"
)

/** begin my answer */

/** begin hidden */
type Arange struct {
	a float64
	b float64
	i int
	n int
	dx float64
}

func arange(a, b float64, n int) Arange {
	return Arange{a, b, 0, n, (b - a) / float64(n - 1)}
}

func (a *Arange) next() (bool, float64) {
	if a.i == a.n {
		return false, 0.0
	} else {
		x := a.a + a.dx * float64(a.i)
		a.i += 1
		return true, x
	}
}

func optimize(f func(float64) float64, rng * Arange) (bool, float64) {
	var miny float64
	ok, x := rng.next()
	i := 0
	for ok {
		y := f(x)
		if i == 0 || y < miny {
			miny = y
		}
		i += 1
		ok, x = rng.next()
	}
	return i > 0, miny
}
/** end hidden */
/** end my answer */
func very_close(x, y float64) bool {
	return math.Abs(x - y) < 1e-6
}

func main() {
	a0 := arange(0, 1, 10000)
	a1 := arange(0, 3, 10000)
	f0 := func (x float64) float64 { return x * (x - 1) }
	f1 := func (x float64) float64 { return x * (x - 1) * (x - 2) }
	if ok, y0 := optimize(f0, &a0); !(ok && very_close(y0, -0.25))     { panic("wrong") }
	if ok, y1 := optimize(f1, &a1); !(ok && very_close(y1, -0.384900)) { panic("wrong") }
	fmt.Println("OK")
}
