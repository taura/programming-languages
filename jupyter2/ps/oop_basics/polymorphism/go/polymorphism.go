package main
import (
	"fmt"
	"math"
)

/** begin my answer */

/** begin hidden */

type FreeShape interface {
	area() float64
} 

type FreeEllipse struct {
	a float64
	b float64
}

func mkFreeEllipse(a, b float64) FreeEllipse {
	return FreeEllipse{a, b}
}

func (e FreeEllipse) area() float64 {
	return math.Pi * e.a * e.b
}

type FreeRect struct {
	w float64
	h float64
}

func mkFreeRect(w, h float64) FreeRect {
	return FreeRect{w, h}
}

func (r FreeRect) area() float64 {
	return r.w * r.h
}

func smaller(s0, s1 FreeShape) int {
	if s0.area() <= s1.area() {
		return 0
	} else {
		return 1
	}
}

/** end hidden */
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
	fmt.Println("OK")
}
