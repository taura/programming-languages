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

func app1[T any](g func(float64) T) T {
	return g(1.0)
}

func app[S any, T any](f func(S) T, x S) T {
	return f(x)
}

/** end hidden */
/** end my answer */
func main() {
	if !(app1(f) == 1.0)                                       { panic("wrong") }
	if !(slices.Equal(app1(g), []float64{1.0}))                { panic("wrong") }
	if !(app(f, 4) == 4)                                       { panic("wrong") }
	if r := app(h, []string{"bye"}); !(r.ok && r.val == "bye") { panic("wrong") }
	fmt.Println("OK")
}
