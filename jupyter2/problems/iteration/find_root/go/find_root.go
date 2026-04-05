package main
import "math"
import "fmt"

/** begin my answer */

/** end my answer */

func main() {
	if !(math.Abs(findRoot(0, 2, 1.0e-20) - 1.5213797) < 1.0e-6) { panic("wrong") }
	fmt.Println("OK")
}
