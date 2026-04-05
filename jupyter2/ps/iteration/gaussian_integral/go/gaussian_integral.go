package main
import "math"
import "fmt"

/** begin my answer */

/** begin hidden */
func gaussianIntegral(a float64, n int64) float64 {
	dx := 2.0 * a / float64(n)
	sum := 0.0
	for i := int64(0); i < n; i++ {
		x := -a + float64(i)*dx
		sum += math.Exp(-x*x) * dx
	}
	return sum
}
/** end hidden */
/** end my answer */

func main() {
	if !(math.Abs(gaussianIntegral(1, 1000) - 1.493648) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(gaussianIntegral(2, 2000) - 1.764163) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(gaussianIntegral(10, 10000) - math.Sqrt(math.Pi)) < 1.0e-6) { panic("wrong") }
	fmt.Println("OK")
}
