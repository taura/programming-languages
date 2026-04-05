package main
import "fmt"
import "math"

/** begin my answer */

/** begin hidden */
func triangleArea(x1, y1, x2, y2, x3, y3 float64) float64 {
	dx21 := x2 - x1
	dy21 := y2 - y1
	dx31 := x3 - x1
	dy31 := y3 - y1
	return 0.5 * math.Abs(dx21*dy31 - dx31*dy21)
}
/** end hidden */
/** end my answer */
func main() {
	if !(math.Abs(triangleArea(0,0,1,0,0,1) - 0.5) < 1.0e-5) { panic("wrong") }
	if !(math.Abs(triangleArea(0,0,2,0,0,2) - 2.0) < 1.0e-5) { panic("wrong") }
	if !(math.Abs(triangleArea(1,1,4,1,1,5) - 6.0) < 1.0e-5) { panic("wrong") }
	fmt.Println("OK")
}
