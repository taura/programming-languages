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
	r0 := mkFreeRect(16., 5.)
	e1 := mkFreeEllipse( 6., 3.)
	r1 := mkFreeRect( 6., 3.)
	if ! veryClose(e0.area(), 251.327412) { panic("wrong") }
	if ! veryClose(r0.area(), 80.)        { panic("wrong") }
	if ! veryClose(e1.area(), 56.548668)  { panic("wrong") }
	if ! veryClose(r1.area(), 18.)        { panic("wrong") }
	if !(smaller(e0, e1) == 1) { panic("wrong") }
	if !(smaller(e0, r0) == 1) { panic("wrong") }
	s0 := mkFreeShapes()
	if ! veryClose(sumArea(s0), 405.876080) { panic("wrong") }
	fmt.Println("OK")
}
