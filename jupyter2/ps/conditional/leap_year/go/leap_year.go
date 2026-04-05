package main
import "fmt"

/** begin my answer */

/** begin hidden */
func isLeapYear(year int64) bool {
	if year % 400 == 0 {
		return true
	} else if year % 100 == 0 {
		return false
	} else if year % 4 == 0 {
		return true
	} else {
		return false
	}
}
/** end hidden */
/** end my answer */
func main() {
	if !isLeapYear(2000) { panic("wrong") }
	if  isLeapYear(1900) { panic("wrong") }
	if !isLeapYear(2024) { panic("wrong") }
	if  isLeapYear(2023) { panic("wrong") }
	fmt.Println("OK")
}
