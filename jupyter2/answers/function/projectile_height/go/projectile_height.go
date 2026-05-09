package main
import "fmt"
import "math"

/** begin my answer */
func height(h0, v0, t float64) float64 {
    return h0 + v0*t - 0.5*9.8*t*t
}
/** end my answer */

func main() {
    if !(math.Abs(height(10,  1, 1) - 6.1) < 1e-5) { panic("wrong") }
    if !(math.Abs(height(20,  0, 2) - 0.4) < 1e-5) { panic("wrong") }
    if !(math.Abs(height(30, -1, 3) - -17.1) < 1e-5) { panic("wrong") }
    fmt.Println("OK")
}

