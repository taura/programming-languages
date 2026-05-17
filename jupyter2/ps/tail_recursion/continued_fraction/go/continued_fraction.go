package main
import "math"
import "fmt"

/** begin my answer */

/** begin hidden */
func continuedFractionTailRec(a float64, m int, xm float64, n int) float64 {
	if m == n  {
		return xm
	} else {
		xm_1 := 1.0 / (a + xm)
		return continuedFractionTailRec(a, m + 1, xm_1, n)
	}
}

func continuedFractionTail(a float64, n int) float64 {
	return continuedFractionTailRec(a, 0, 1.0, n)
}
/** end hidden */
/** end my answer */

func main() {
	if !(math.Abs(continuedFractionTail(2.0, 100) - 0.4142136) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(continuedFractionTail(3.0, 100) - 0.3027756) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(continuedFractionTail(4.0, 100) - 0.2360680) < 1.0e-6) { panic("wrong") }
	fmt.Println("OK")
}
