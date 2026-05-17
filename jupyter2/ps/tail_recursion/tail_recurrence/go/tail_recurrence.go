package main
import "math"
import "fmt"

/** begin my answer */

/** begin hidden */
func affineRecurrenceSimpleTailRec(a, b float64, m int64, xm float64, n int64) float64 {
	if m == n {
		return xm
	} else {
		xm_1 := a * xm + b
		return affineRecurrenceSimpleTailRec(a, b, m + 1, xm_1, n)
	}
}

func affineRecurrenceSimpleTail(a, b, c float64, n int64) float64 {
	return affineRecurrenceSimpleTailRec(a, b, 0, c, n)
}
	
func affineRecurrenceFastTailRec(a, b float64, m int64, xm float64, n int64) float64 {
	if m == n {
		return xm
	} else if (n - m) % 2 == 0 {
		return affineRecurrenceFastTailRec(a * a, a * b + b, m, xm, (m + n) / 2)
	} else {
		xm_1 := a * xm + b
		return affineRecurrenceFastTailRec(a, b, m + 1, xm_1, n)
	}
}

func affineRecurrenceFastTail(a, b, c float64, n int64) float64 {
	return affineRecurrenceFastTailRec(a, b, 0, c, n)
}
/** end hidden */
/** end my answer */

func main() {
	if !(math.Abs(affineRecurrenceFastTail(0.9999, 1.0, 2.0, 100000)  - 9999.5463184) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(affineRecurrenceSimpleTail(0.9999, 1.0, 2.0, 100000)  - 9999.5463184) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(affineRecurrenceFastTail(0.9999, 1.0, 2.0, 1000000) - 10000.0) < 1.0e-6) { panic("wrong") }
	if !(math.Abs(affineRecurrenceSimpleTail(0.9999, 1.0, 2.0, 1000000) - 10000.0) < 1.0e-6) { panic("wrong") }
	fmt.Println("OK")
}
