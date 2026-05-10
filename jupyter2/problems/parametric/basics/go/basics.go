package main
import (
	"fmt"
	"slices"
)

/** begin my answer */

/** end my answer */
func main() {
	if !(f(1) == 1)                                            { panic("wrong") }
	if !(f("hello") == "hello")                                { panic("wrong") }
	if !(slices.Equal(g(2), []int{2}))                         { panic("wrong") }
	if !(slices.Equal(g("world"), []string{"world"}))          { panic("wrong") }
	c0 := &Cell[int]{0}
	if !(get(c0) == 0)                                         { panic("wrong") }
	put(c0, 42)
	c1 := &Cell[string]{"mimura"}
	if !(get(c1) == "mimura")                                  { panic("wrong") }
	put(c1, "ohtake");
	if !(get(c1) == "ohtake")                                  { panic("wrong") }
	if !(!h([]int{}).ok)                                       { panic("wrong") }
	if r := h([]int{3}); !(r.ok && r.val == 3)                 { panic("wrong") }
	if r := h([]string{"bye"}); !(r.ok && r.val =="bye")       { panic("wrong") }
	fmt.Println("OK")
}
