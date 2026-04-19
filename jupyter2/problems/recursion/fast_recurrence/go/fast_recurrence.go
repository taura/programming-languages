package main
import "math"
import "fmt"

func affineRecurrenceIter(a, b, c float64, n int64) float64 {
	x := c
	for i := int64(0); i < n; i++ {
		x = a * x + b
	}
	return x
}
/** begin my answer */

/** end my answer */

func main() {
	if !(math.Abs(affineRecurrenceSimple(0.9,  1.0, 2.0, 100)     - 9.9997875) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(affineRecurrenceSimple(0.99, 1.0, 2.0, 1000)    - 99.9957692) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(affineRecurrenceFast(0.99,   1.0, 2.0, 1000)    - 99.9957692) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(affineRecurrenceFast(0.99,   1.0, 2.0, 10000)   - 100.0) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(affineRecurrenceFast(0.999,  1.0, 2.0, 10000)   - 999.9549170) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(affineRecurrenceFast(0.999,  1.0, 2.0, 100000)  - 1000.0) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(affineRecurrenceFast(0.9999, 1.0, 2.0, 100000)  - 9999.5463184) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(affineRecurrenceIter(0.9999, 1.0, 2.0, 100000)  - 9999.5463184) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(affineRecurrenceFast(0.9999, 1.0, 2.0, 1000000) - 10000.0) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(affineRecurrenceIter(0.9999, 1.0, 2.0, 1000000) - 10000.0) < 1.0e-6) { panic("wrong") }
	fmt.Println("OK")
}
