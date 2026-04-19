package main
import (
	"fmt"
	"slices"
)

/** begin my answer */

/** end my answer */

func insert_seq(xs []uint, t *BSTree) *BSTree {
	for _, x := range xs {
		t = insert(x, t)
	}
	return t
}

func random_seq(n int, seed uint) []uint {
	x := seed
	xs := make([]uint, n)
	for i := 0; i < n; i++ {
		x = (0x5DEECE66D * x + 0xB) & 0xFFFFFFFFFFFF
		xs[i] = x >> 17
	}
	return xs
}

func check_seq(xs []uint, m int) bool {
	t := insert_seq(xs, nil)
	sorted := slices.Clone(xs)
	slices.Sort(sorted)
	return uint(nth(m, t)) == sorted[m]
}

func check_random(seed uint, n int, m int) bool {
	xs := random_seq(n, seed)
	return check_seq(xs, m)
}

func main() {
	if !check_seq([]uint{1,2,4,0,3}, 2) { panic("wrong") }
	if !check_random(123,      10,      3) { panic("wrong") }
	if !check_random(123,     100,     40) { panic("wrong") }
	if !check_random(123,    1000,    500) { panic("wrong") };
	if !check_random(123,   10000,   6000) { panic("wrong") };
	if !check_random(123,  100000,  70000) { panic("wrong") };
	if !check_random(123, 1000000, 800000) { panic("wrong") };
	fmt.Println("OK")
}
