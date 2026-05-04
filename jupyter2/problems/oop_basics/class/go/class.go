package main
import (
	"fmt"
	"math"
)

/** begin my answer */

/** end my answer */
func veryClose(x, y float64) bool {
	return math.Abs(x - y) < 1e-6
}

func main() {
	e0 := mkFreeEllipse(16., 5.)
	e1 := mkFreeEllipse( 6., 3.)
	if ! veryClose(e0.area(), 251.327412) { panic("wrong") }
	if ! veryClose(e1.area(), 56.548668)  { panic("wrong") }
	if !(smaller(e0, e1) == 1) { panic("wrong") }
	fmt.Println("OK")
}
