package main
import "math"
import "fmt"

/** begin my answer */

/** end my answer */

func main() {
	if !(math.Abs(continuedFractionTail(2.0, 100) - 0.4142136) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(continuedFractionTail(3.0, 100) - 0.3027756) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(continuedFractionTail(4.0, 100) - 0.2360680) < 1.0e-6) { panic("wrong") }
	fmt.Println("OK")
}
