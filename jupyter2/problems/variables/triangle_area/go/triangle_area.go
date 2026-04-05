package main
import "fmt"
import "math"

/** begin my answer */

/** end my answer */
func main() {
	if !(math.Abs(triangleArea(0,0,1,0,0,1) - 0.5) < 1.0e-5) { panic("wrong") }
	if !(math.Abs(triangleArea(0,0,2,0,0,2) - 2.0) < 1.0e-5) { panic("wrong") }
	if !(math.Abs(triangleArea(1,1,4,1,1,5) - 6.0) < 1.0e-5) { panic("wrong") }
	fmt.Println("OK")
}
