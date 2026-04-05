package main
import "fmt"

/** begin my answer */

/** begin hidden */
func inCircle(x,y,r float64) bool {
    return x*x + y*y <= r*r
}
/** end hidden */
/** end my answer */
func main() {
	if !inCircle(1, 1, 2) { panic("wrong") }
	if !inCircle(3, 4, 6) { panic("wrong") }
	if  inCircle(3, 0, 2) { panic("wrong") }
	fmt.Println("OK")
}
