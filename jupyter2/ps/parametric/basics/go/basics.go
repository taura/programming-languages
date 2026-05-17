package main
import (
	"fmt"
	"slices"
)

/** begin my answer */

/** begin hidden */
func f[T any](x T) T {
	return x
}

func g[T any](x T) []T {
	return []T{x}
}

type Cell[T any] struct {
	x T
}

func get[T any](c *Cell[T]) T {
	return c.x
}

func put[T any](c *Cell[T], y T) {
	c.x = y
}

type Option[T any] struct {
	ok bool
	val T
}

func h[T any](a []T) Option[T] {
	if len(a) == 0 {
		var z T
		return Option[T]{false, z}
	} else {
		return Option[T]{true, a[0]}
	}
}
/** end hidden */
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
