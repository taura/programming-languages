package main
import "fmt"

/** begin my answer */

/** end my answer */
func main() {
	if !isLeapYear(2000) { panic("wrong") }
	if  isLeapYear(1900) { panic("wrong") }
	if !isLeapYear(2024) { panic("wrong") }
	if  isLeapYear(2023) { panic("wrong") }
	fmt.Println("OK")
}
