package main
import "math"
import "fmt"

/** begin my answer */

/** end my answer */

func main() {
	if !(math.Abs(gaussianIntegral(1, 1000) - 1.493648) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(gaussianIntegral(2, 2000) - 1.764163) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(gaussianIntegral(10, 10000) - math.Sqrt(math.Pi)) < 1.0e-6) { panic("wrong") }
	fmt.Println("OK")
}
