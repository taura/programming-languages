package main
import "fmt"
import "math"

/** begin my answer */

/** end my answer */
func main() {
	if !(math.Abs(f(1.0, 2.0, 3.0) - -4.0) < 1.0e-5) { panic("wrong") }
	if !(math.Abs(f(3.0, 4.0, 5.0) -  0.0) < 1.0e-5) { panic("wrong") }
	if !(math.Abs(f(5.0, 6.0, 7.0) - 12.0) < 1.0e-5) { panic("wrong") }
	fmt.Println("OK")
}
