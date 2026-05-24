package how_compiled

type Point struct {
    x float64
    y float64
}

func mkPoint(x, y float64) Point {
	p := Point{x: x + 1.0, y: y + 2.0}
	return p
}
