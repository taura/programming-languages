package main
import "fmt"
import "math"

/** begin my answer */

/** end my answer */
func main() {
	if !(math.Abs(gaussianDensity(0.0, 1.0, 0.0) - 0.398942) < 1.0e-5) { panic("wrong") }
	if !(math.Abs(gaussianDensity(0.0, 2.0, 1.0) - 0.176033) < 1.0e-5) { panic("wrong") }
	if !(math.Abs(gaussianDensity(1.0, 3.0, 5.0) - 0.054670) < 1.0e-5) { panic("wrong") }
	fmt.Println("OK")
}
