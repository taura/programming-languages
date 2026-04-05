package main
import "fmt"
import "math"

/** begin my answer */

/** begin hidden */
func compound(p, r, t float64) float64 {
    return p * math.Pow(1+r, t)
}
/** end hidden */
/** end my answer */
func main() {
	if !(math.Abs(compound(100, 0.1, 2) - 121) < 1e-5) { panic("wrong") }
	if !(math.Abs(compound(100, 0.2, 5) - 248.832) < 1e-5) { panic("wrong") }
	if !(math.Abs(compound(100, 0.3, 10) - 1378.584918) < 1e-5) { panic("wrong") }
	fmt.Println("OK")
}
