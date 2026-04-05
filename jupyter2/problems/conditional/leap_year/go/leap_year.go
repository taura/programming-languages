package main
import "fmt"

/** begin my answer */

/** end my answer */
func main() {
	if !IsLeapYear(2000) { panic("wrong") }
	if  IsLeapYear(1900) { panic("wrong") }
	if !IsLeapYear(2024) { panic("wrong") }
	if  IsLeapYear(2023) { panic("wrong") }
	fmt.Println("OK")
}
