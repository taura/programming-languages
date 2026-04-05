package main
import "fmt"
import "math"

/** begin my answer */

/** begin hidden */
func sigmoid(x float64) float64 {
    return 1.0 / (1.0 + math.Exp(-x))
}
/** end hidden */
/** end my answer */
func main() {
    if !(math.Abs(sigmoid(-5.0) - 0.00669) < 1e-5) { panic("wrong") }
    if !(math.Abs(sigmoid(-0.5) - 0.37754) < 1e-5) { panic("wrong") }
    if !(math.Abs(sigmoid(0.0) - 0.5) < 1e-5) { panic("wrong") }
    if !(math.Abs(sigmoid(10.0) - 0.999954) < 1e-5) { panic("wrong") }
    fmt.Println("OK")
}
