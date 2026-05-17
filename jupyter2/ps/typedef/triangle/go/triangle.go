package main
import (
	"fmt"
	"math"
)

/** begin my answer */

/** begin hidden */
type Vec2 struct {
	x, y float64
}

type Triangle struct {
	a, b, c Vec2
}

func vec2Minus(a, b Vec2) Vec2 {
	return Vec2{a.x - b.x, a.y - b.y}
}

func cross(a, b Vec2) float64 {
	return a.x * b.y - a.y * b.x
}

func areaOfTriangle(t Triangle) float64 {
	ab := vec2Minus(t.b, t.a)
	ac := vec2Minus(t.c, t.a)
	return 0.5 * math.Abs(cross(ab, ac))
}

/** end hidden */
/** end my answer */
func check(x0, y0, x1, y1, x2, y2, a float64) bool {
	t := Triangle{Vec2{x0, y0}, Vec2{x1, y1}, Vec2{x2, y2}}
	return math.Abs(areaOfTriangle(t) - a) < 1e-6
}

func main() {
	if !check(0.,  0.,  1.,  0.,  0.,  1.,   0.500) { panic("wrong") }
	if !check(9.9, 0.3, 3.2, 5.1, 6.1, 0.2,  9.455) { panic("wrong") }
	if !check(4.6, 6.4, 0.4, 0.3, 5.5, 9.1,  2.925) { panic("wrong") }
	if !check(5.2, 5.5, 9.9, 0.0, 3.1, 4.0,  9.300) { panic("wrong") }
	if !check(6.0, 1.2, 0.6, 5.5, 9.9, 3.2, 13.785) { panic("wrong") }
	fmt.Println("OK")
}
