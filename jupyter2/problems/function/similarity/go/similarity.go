package main
import "fmt"
import "math"

/** begin my answer */

/** end my answer */
func main() {
	if !(math.Abs(similarity(1.0, 2.0,  2.0,  4.0) - 1.0) < 1e-5) { panic("wrong") }
	if !(math.Abs(similarity(1.0, 2.0,  3.0,  5.0) - 0.997054) < 1e-5) { panic("wrong") }
	if !(math.Abs(similarity(2.0, 3.0,  3.0, -2.0) - 0.0) < 1e-5) { panic("wrong") }
	if !(math.Abs(similarity(3.0, 4.0, -3.0, -1.0) - -0.82219) < 1e-5) { panic("wrong") }
	fmt.Println("OK")
}
