package main
import (
	"fmt"
	"math"
)

/** begin my answer */

/** begin hidden */
type Domain[T any] interface {
	next() (bool, T)
}

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

type Arange2d struct {
	x0 float64
	x1 float64
	m int
	y0 float64
	y1 float64
	n int
	i int
	j int
	dx float64
	dy float64
}

func arange2d(x0, x1 float64, m int, y0, y1 float64, n int) Arange2d {
	return Arange2d{x0, x1, m, y0, y1, n, 0, 0, (x1 - x0) / float64(m - 1), (y1 - y0) / float64(n - 1)}
}

func (a *Arange2d) next() (bool, [2]float64) {
	if a.i == a.m {
		return false, [2]float64{0.0, 0.0}
	} else {
		x := a.x0 + a.dx * float64(a.i)
		y := a.y0 + a.dy * float64(a.j)
		if a.j + 1 == a.n {
			a.i += 1
			a.j = 0
		} else {
			a.j += 1
		}
		return true, [2]float64{x, y}
	}
}

func optimize[S any](f func(S) float64, rng Domain[S]) (bool, float64) {
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
	a2 := arange2d(-2, 2, 10000, -2, 2, 10000)
	f0 := func (x float64) float64 { return x * (x - 1) }
	f1 := func (x float64) float64 { return x * (x - 1) * (x - 2) }
	f2 := func (x [2]float64) float64 { return x[0] * x[0] + 2 * x[1] * x[1] + 3 * x[0] * x[1] }
	if ok, y0 := optimize(f0, &a0); !(ok && very_close(y0, -0.25))     { panic("wrong") }
	if ok, y1 := optimize(f1, &a1); !(ok && very_close(y1, -0.384900)) { panic("wrong") }
	if ok, y2 := optimize(f2, &a2); !(ok && very_close(y2, -0.5))      { panic("wrong") }
	fmt.Println("OK")
}
