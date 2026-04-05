package main
import "math"
import "fmt"

/** begin my answer */

/** begin hidden */
func minValue(a, b float64, n int64) float64 {
	best := a*a*a*a - 3.0*a*a*a + 2.0*a*a + a + 1.0
	for i := int64(1); i <= n; i++ {
		x := a + (b-a)*float64(i)/float64(n)
		v := x*x*x*x - 3.0*x*x*x + 2.0*x*x + x + 1.0
		if v < best {
			best = v
		}
	}
	return best
}
/** end hidden */
/** end my answer */

func main() {
	if !(math.Abs(minValue(-1, 1, 1000) - 0.903266) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(minValue( 1, 2, 1000) - 1.928766) < 1.0e-6) { panic("wrong") }
	fmt.Println("OK")
}
