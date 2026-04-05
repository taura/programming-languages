package main
import "math"
import "fmt"

/** begin my answer */

/** end my answer */

func main() {
	if !(math.Abs(minValue(-1, 1, 1000) - 0.903266) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(minValue( 1, 2, 1000) - 1.928766) < 1.0e-6) { panic("wrong") }
	fmt.Println("OK")
}
