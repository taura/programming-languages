package main
import "fmt"
import "math"

/** begin my answer */

/** begin hidden */
func pointLineDistance(x0, y0, x1, y1, p, q float64) float64 {
	dx := x1 - x0
	dy := y1 - y0
	a := dy
	b := -dx
	num := math.Abs(a * (p - x0) + b * (q - y0))
	den := math.Sqrt(a * a + b * b)
	return num / den
}
/** end hidden */
/** end my answer */
func main() {
	if !(math.Abs(pointLineDistance(-3.0, 1.0, 1.0, -2.0, 4.0, -3.0) - 1.0) < 1.0e-5) { panic("wrong") }
	if !(math.Abs(pointLineDistance( 2.0, 2.0, 4.0,  0.0, 1.0,  0.0) - 2.12132) < 1.0e-5) { panic("wrong") }
	if !(math.Abs(pointLineDistance( 1.0, 1.0, 4.0,  3.0, 3.0, -2.0) - 3.60555) < 1.0e-5) { panic("wrong") }
	fmt.Println("OK")
}
