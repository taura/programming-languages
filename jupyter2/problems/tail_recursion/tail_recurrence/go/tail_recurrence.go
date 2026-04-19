package main
import "math"
import "fmt"

/** begin my answer */

/** end my answer */

func main() {
	if !(math.Abs(affineRecurrenceFastTail(0.9999, 1.0, 2.0, 100000)  - 9999.5463184) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(affineRecurrenceSimpleTail(0.9999, 1.0, 2.0, 100000)  - 9999.5463184) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(affineRecurrenceFastTail(0.9999, 1.0, 2.0, 1000000) - 10000.0) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(affineRecurrenceSimpleTail(0.9999, 1.0, 2.0, 1000000) - 10000.0) < 1.0e-6) { panic("wrong") }
	fmt.Println("OK")
}
