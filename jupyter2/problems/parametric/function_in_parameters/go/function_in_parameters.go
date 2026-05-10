package main
import (
	"fmt"
	"slices"
)

/** begin my answer */

/** end my answer */
func main() {
	if !(app1(f) == 1.0)                                       { panic("wrong") }
	if !(slices.Equal(app1(g), []float64{1.0}))                { panic("wrong") }
	if !(app(f, 4) == 4)                                       { panic("wrong") }
	if r := app(h, []string{"bye"}); !(r.ok && r.val == "bye") { panic("wrong") }
	fmt.Println("OK")
}
