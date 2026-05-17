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

type Shape interface {
	FreeShape
	contains(x, y float64) bool
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

type Ellipse struct {
	FreeEllipse
	x0 float64
	y0 float64
}

func mkEllipse(a, b, x0, y0 float64) Ellipse {
	return Ellipse{FreeEllipse{a, b}, x0, y0}
}

func (e Ellipse) contains(x, y float64) bool {
	dx := x - e.x0
	dy := y - e.y0
	return (dx*dx)/(e.a*e.a) + (dy*dy)/(e.b*e.b) <= 1.0
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

type Rect struct {
	FreeRect
	x0 float64
	y0 float64
}

func mkRect(w, h, x0, y0 float64) Rect {
	return Rect{FreeRect{w, h}, x0, y0}
}

func (r Rect) contains(x, y float64) bool {
	return x >= r.x0 && x <= r.x0 + r.w && y >= r.y0 && y <= r.y0 + r.h
}

func smaller(s0, s1 FreeShape) int {
	if s0.area() <= s1.area() {
		return 0
	} else {
		return 1
	}
}

func mkFreeShapes() []FreeShape {
	return []FreeShape{
		mkFreeEllipse(16., 5.),
		mkFreeRect(16., 5.),
		mkFreeEllipse(6., 3.),
		mkFreeRect(6., 3.),
	}
}

func mkShapes() []Shape {
	return []Shape{
		mkEllipse(16., 5., -15., -4.),
		mkRect(16., 5., -15., -4.),
		mkEllipse(6., 3., -3., -2.),
		mkRect(6., 3., -3., -2.),
	}
}

func mkMixedShapes() []FreeShape {
	return []FreeShape{
		mkFreeEllipse(16., 5.),
		mkFreeRect(16., 5.),
		mkFreeEllipse(6., 3.),
		mkFreeRect(6., 3.),
		mkEllipse(16., 5., -15., -4.),
		mkRect(16., 5., -15., -4.),
		mkEllipse(6., 3., -3., -2.),
		mkRect(6., 3., -3., -2.),
	}
}

func sumArea(seq []FreeShape) float64 {
	s := 0.
	for _, sh := range seq {
		s += sh.area()
	}
	return s
}

func countContains(seq []Shape, x, y float64) int {
	c := 0
	for _, sh := range seq {
		if sh.contains(x, y) {
			c += 1
		}
	}
	return c
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
