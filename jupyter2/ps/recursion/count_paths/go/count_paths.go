package main
import "fmt"

/** begin my answer */

/** begin hidden */
func countPaths(a, b int64) int64 {
	if a == 0 || b == 0 {
		return 1
	} else {
		return countPaths(a - 1, b) + countPaths(a, b - 1)
	}
}

func countPathsBelowRec(p, q, a, b int64) int64 {
	if p == 0 || q == 0 {
		return 1
	} else if -b * p + a * q > 0 {
		return 0
	} else {
		return countPathsBelowRec(p - 1, q, a, b) + countPathsBelowRec(p, q - 1, a, b)
	}
}

func countPathsBelow(a, b int64) int64 {
	return countPathsBelowRec(a, b, a, b)
}
/** end hidden */
/** end my answer */

func main() {
	if !(countPaths(7, 3)        == 120)       { panic("wrong") }
	if !(countPathsBelow(7, 3)   == 12)        { panic("wrong") }
	if !(countPaths(12, 8)       == 125970)    { panic("wrong") }
	if !(countPathsBelow(12, 8)  == 7229)      { panic("wrong") }
	if !(countPaths(17, 13)      == 119759850) { panic("wrong") }
	if !(countPathsBelow(17, 13) == 3991995)   { panic("wrong") }
	fmt.Println("OK")
}
