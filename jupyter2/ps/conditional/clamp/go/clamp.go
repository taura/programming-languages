package main
import "fmt"
import "math"

/** begin my answer */

/** begin hidden */
func clamp(x, low, high float64) float64 {
	if x < low {
		return low
	} else if x > high {
		return high
	} else {
		return x
	}
}
/** end hidden */
/** end my answer */
func main() {
	if !(math.Abs(clamp(-3.0, 0.0, 10.0) -  0.0) < 1.0e-5) { panic("wrong") }
	if !(math.Abs(clamp( 4.0, 0.0, 10.0) -  4.0) < 1.0e-5) { panic("wrong") }
	if !(math.Abs(clamp(15.0, 0.0, 10.0) - 10.0) < 1.0e-5) { panic("wrong") }
	fmt.Println("OK")
}
