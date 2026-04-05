package main
import "math"
import "fmt"

/** begin my answer */

/** begin hidden */
func seriesSum(n int64) float64 {
	sum := 0.0
	for k := int64(1); k <= n; k++ {
		x := float64(k)
		sum += 1.0 / (x * x)
	}
	return sum
}
/** end hidden */
/** end my answer */

func main() {
	a := math.Pi * math.Pi / 6.0
	if !(math.Abs(seriesSum(10) - 1.549768) < 1.0e-5) { panic("wrong") }
	if !(math.Abs(seriesSum(100000) - a) < 1.0e-5) { panic("wrong") }
	if !(math.Abs(seriesSum(1000000) - a) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(seriesSum(20000000) - a) < 1.0e-6) { panic("wrong") }
	fmt.Println("OK")
}
