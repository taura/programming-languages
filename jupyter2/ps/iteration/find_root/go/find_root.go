package main
import "math"
import "fmt"

/** begin my answer */

/** begin hidden */
func findRoot(a, b, eps float64) float64 {
	f := func(x float64) float64 { return x*x*x - x - 2.0 }
	l := a
	r := b
	for math.Abs(r - l) > eps {
		c := 0.5 * (l + r)
		if f(l)*f(c) < 0.0 {
			r = c
		} else {
			l = c
		}
	}
	return 0.5 * (l + r)
}
/** end hidden */
/** end my answer */

func main() {
	if !(math.Abs(findRoot(0, 2, 1.0e-20) - 1.5213797) < 1.0e-6) { panic("wrong") }
	fmt.Println("OK")
}
