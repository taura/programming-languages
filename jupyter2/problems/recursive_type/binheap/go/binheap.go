package main

import (
	"fmt"
	"slices"
)

/** begin my answer */
/** end my answer */

// add all values in list xs to tree t in order
func addSeq(xs []int, t *BinHeap) *BinHeap {
	for _, x := range xs {
		t = binHeapAdd(x, t)
	}
	return t
}

// remove all values from t and push them in front of xs
func binHeapToSeq(t *BinHeap) []int {
	xs := append([]int{})
	for t != nil {
		x, t_ := binHeapRemoveMin(t)
		xs = append(xs, x)
		t = t_
	}
	return xs
}

// 0 ... n - 1
func mkRange(n int) []int {
	s := make([]int, n)
	for i := 0; i < n; i++ {
		s[i] = i
	}
	return s
}

// random sequence
func randomSeq(n int, x int) []int {
	seq := make([]int, n)
	for i := 0; i < n; i++ {
		x = (0x5DEECE66D * x + 0xB) & 0xFFFFFFFFFFFF
		seq[i] = x >> 17
	}
	return seq
}

// randomly shuffle xs
type Pair struct {
	k int
	x int
}

func randomShuffle(seed int, xs []int) []int {
	ys := randomSeq(len(xs), seed)
	ps := make([]Pair, len(xs))
	for i, x := range xs {
		ps[i].k = ys[i]
		ps[i].x = x
	}
	slices.SortFunc(ps, func(a, b Pair) int {
		return a.k - b.k
	})
	for i, z := range ps {
		ys[i] = z.x
	}
	return ys
}

// add xs to empty tree; remove all elements from the tree;
// check if they are sorted

func printSlice(header string, xs []int, n int) {
	fmt.Print(header, "[")
	for i, x := range xs {
		if i >= n {
			fmt.Print(" ...")
			break
		}
		if i > 0 {
			fmt.Print(", ")
		}
		fmt.Print(x)
	}
	fmt.Println("]")	
}	

func checkSeq(xs []int) bool {
	printSlice("input:  ", xs, 7)
	t := addSeq(xs, nil)
	ys := binHeapToSeq(t)
	printSlice("output: ", ys, 7)
	zs := slices.Sorted(slices.Values(xs))
	return slices.Equal(ys, zs)
}

// randomly shuffle 0 .. n-1;
//   add them to empty tree;
//   remove all elements from the tree;
//   check they are sorted

func checkRandom(seed int, n int) bool {
	rng := mkRange(n)
	xs := randomShuffle(seed, rng)
	return checkSeq(xs)
}

func main() {
	seed := 12345
	if (!checkRandom(seed, 2))      { panic("wrong") }
	if (!checkRandom(seed, 3))      { panic("wrong") }
	if (!checkRandom(seed, 4))      { panic("wrong") }
	if (!checkRandom(seed, 5))      { panic("wrong") }
	if (!checkRandom(seed, 10))     { panic("wrong") }
	if (!checkRandom(seed, 100))    { panic("wrong") }
	if (!checkRandom(seed, 1000))   { panic("wrong") }
	if (!checkRandom(seed, 10000))  { panic("wrong") }
	if (!checkRandom(seed, 100000)) { panic("wrong") }
	fmt.Println("OK")
}
