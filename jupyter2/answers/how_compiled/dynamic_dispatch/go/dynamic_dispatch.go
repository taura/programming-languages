package how_compiled

type Shape interface {
	area() float64
}

func CallArea(s Shape) float64 {
	return s.area()
}
