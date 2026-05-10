package main
import (
	"fmt"
	"math"
)

/** begin my answer */

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
