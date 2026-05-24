package how_compiled
import "math"

func CallTanh(x float64) float64 {
	return math.Tanh(x + 1.0) + x
}
