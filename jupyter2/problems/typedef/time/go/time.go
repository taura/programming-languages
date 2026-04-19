package main
import "fmt"

/** begin my answer */

/** end my answer */
func main() {
	if !((timeDiff(Time{hour: 12, minute: 0, second: 0.0}, Time{hour: 11, minute: 30, second: 0.0}) - 1800.0) < 1e-6) { panic("wrong") }
	if !((timeDiff(Time{hour: 23, minute: 59, second: 59.9}, Time{hour: 0, minute: 0, second: 0.0}) - 86399.9) < 1e-6) { panic("wrong") }
	fmt.Println("OK")
}
