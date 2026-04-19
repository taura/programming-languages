package main
import "fmt"

/** begin my answer */

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
