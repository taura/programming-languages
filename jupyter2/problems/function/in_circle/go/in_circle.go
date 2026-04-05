package main
import "fmt"

/** begin my answer */

/** end my answer */
func main() {
	if !inCircle(1, 1, 2) { panic("wrong") }
	if !inCircle(3, 4, 6) { panic("wrong") }
	if  inCircle(3, 0, 2) { panic("wrong") }
	fmt.Println("OK")
}
