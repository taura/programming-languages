package main
import "fmt"
import "math"

/** begin my answer */

/** begin hidden */
func gaussianDensity(mu, sigma, x float64) float64 {
	z := (x - mu) / sigma
	z2 := z * z
	norm := 1.0 / (math.Sqrt(2.0 * math.Pi) * sigma)
	return norm * math.Exp(-0.5 * z2)
}
/** end hidden */
/** end my answer */
func main() {
	if !(math.Abs(gaussianDensity(0.0, 1.0, 0.0) - 0.398942) < 1.0e-5) { panic("wrong") }
	if !(math.Abs(gaussianDensity(0.0, 2.0, 1.0) - 0.176033) < 1.0e-5) { panic("wrong") }
	if !(math.Abs(gaussianDensity(1.0, 3.0, 5.0) - 0.054670) < 1.0e-5) { panic("wrong") }
	fmt.Println("OK")
}
