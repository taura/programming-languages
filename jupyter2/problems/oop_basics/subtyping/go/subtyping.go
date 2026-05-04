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
	d0 := mkEllipse(16., 5., -15., -4.)
	q0 := mkRect(16., 5., -15., -4.)
	d1 := mkEllipse( 6., 3.,  -3., -2.)
	q1 := mkRect( 6., 3.,  -3., -2.)
	if ! veryClose(e0.area(), 251.327412) { panic("wrong") }
	if ! veryClose(r0.area(), 80.)        { panic("wrong") }
	if ! veryClose(e1.area(), 56.548668)  { panic("wrong") }
	if ! veryClose(r1.area(), 18.)        { panic("wrong") }
	if ! veryClose(d0.area(), 251.327412) { panic("wrong") }
	if ! veryClose(q0.area(), 80.)        { panic("wrong") }
	if ! veryClose(d1.area(), 56.548668)  { panic("wrong") }
	if ! veryClose(q1.area(), 18.)        { panic("wrong") }
	if !(smaller(e0, e1) == 1) { panic("wrong") }
	if !(smaller(e0, r0) == 1) { panic("wrong") }
	if !(smaller(d1, q0) == 0) { panic("wrong") }
	if !(smaller(e0, d0) == 0) { panic("wrong") }
	s0 := mkFreeShapes()
	s1 := mkShapes()
	s2 := mkMixedShapes()
	// un-comment only lines below that run successfully
	// if ! (countContains(s0, 0.0, 0.0) == 3) { panic("wrong") }
	if ! (countContains(s1, 0.0, 0.0) == 3) { panic("wrong") }
	// if ! (countContains(s2, 0.0, 0.0) == 6) { panic("wrong") }
	if ! veryClose(sumArea(s0), 405.876080) { panic("wrong") }
	// if ! veryClose(sumArea(s1), 405.876080) { panic("wrong") }
	if ! veryClose(sumArea(s2), 811.752160) { panic("wrong") }
	fmt.Println("OK")
}
