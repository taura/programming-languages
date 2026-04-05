package main
import "fmt"
import "math"

/** begin my answer */

/** end my answer */
func main() {
	if !(math.Abs(pointLineDistance(-3.0, 1.0, 1.0, -2.0, 4.0, -3.0) - 1.0) < 1.0e-5) { panic("wrong") }
	if !(math.Abs(pointLineDistance( 2.0, 2.0, 4.0,  0.0, 1.0,  0.0) - 2.12132) < 1.0e-5) { panic("wrong") }
	if !(math.Abs(pointLineDistance( 1.0, 1.0, 4.0,  3.0, 3.0, -2.0) - 3.60555) < 1.0e-5) { panic("wrong") }
	fmt.Println("OK")
}
