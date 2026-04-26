package main
import (
	"fmt"
	"slices"
)

/** begin my answer */

/** end my answer */

/* test code below */

// insert all numbers in xs into t, and return the resulting tree
func insert_seq(xs []uint, t *BSTree) *BSTree {
	for _, x := range xs {
		t = insert(x, t)
	}
	return t
}

// generate a sequence of n random numbers with seed
func random_seq(n int, seed uint) []uint {
	x := seed
	xs := make([]uint, n)
	for i := 0; i < n; i++ {
		x = (0x5DEECE66D * x + 0xB) & 0xFFFFFFFFFFFF
		xs[i] = x >> 17
	}
	return xs
}

// insert all numbers in xs to an empty tree, and check that the m-th smallest number is correct
func check_seq(xs []uint, m int) bool {
	t := insert_seq(xs, nil)
	sorted := slices.Clone(xs)
	slices.Sort(sorted)
	return uint(nth(m, t)) == sorted[m]
}

// generate a sequence of n random numbers with seed, insert them to an empty tree,
// and check that the m-th smallest number is correct
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
