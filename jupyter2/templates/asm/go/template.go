package how_compiled
import "math"

// (1)
func AddNums(x, y int64) int64 {
    return x + y + 123;
}

func AddInts(x, y int64) int64 {
    return x + y + 123;
}

func AddFloats(x, y float64) float64 {
    return x + y + 12.3
}

// (2)
type Point struct {
    x float64
    y float64
}

func GetPointY(p Point) float64 {
    return p.y
}

func GetPointYPtr(p * Point) float64 {
    return p.y
}

// (3)
func GetFloatArray3ElemConst(a [3]float64) float64 {
    return a[2]
}

func GetFloatArray3ElemVar(a [3]float64, i int64) float64 {
    return a[i]
}

func GetFloatSliceElemConst(a []float64) float64 {
    return a[2]
}

func GetFloatSliceElemVar(a []float64, i int64) float64 {
    return a[i]
}

// (4)
func Collatz(n int64) int64 {
	if n % 2 == 0 {
		return n / 2
	} else {
		return 3 * n + 1
	}
}

func Gcd1(a int64, b int64) int64 {
	if b == 0 {
		return a
	} else {
		return a % b
	}
}

// (5)
func SumArrayLoop(a []float64, n int64) float64 {
	s := 0.0
	var i int64;
	for i = 0; i < n; i++ {
		s += a[i]
	}
	return s;
}

// (6)
func CallTanh(x float64) float64 {
	return math.Tanh(x + 1.0) + x
}

// (7)
func SumArrayRec(a []float64, n int64) float64 {
	if (n == 0) {
		return 0.0
	} else {
		return SumArrayRec(a, n - 1) + a[n]
	}
}

// (8)
func SumArrayTail(a []float64, i int64, n int64, s float64) float64 {
	if i == n {
		return s
	} else {
		return SumArrayTail(a, i + 1, n, s + a[i])
	}
}

// (9)
func mkPoint(x, y float64) Point {
	p := Point{x: x + 1.0, y: y + 2.0}
	return p
}

func mkPointP(x, y float64) *Point {
	p := Point{x: x, y: y}
	return &p
}

// (10)
func mkArray10(x float64) [10]float64 {
	a := [10]float64{x, x, x, x, x, x, x, x, x, x}
	return a
}

func mkSlice10(x float64) []float64 {
	a := []float64{x, x, x, x, x, x, x, x, x, x}
	return a
}

// (11)
type Shape interface {
	area() float64
}

func CallArea(s Shape) float64 {
	return s.area()
}

func main() {
	println(CallTanh(4.0))
}
