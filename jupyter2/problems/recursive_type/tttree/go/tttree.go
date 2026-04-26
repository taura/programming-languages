package main
import (
	"fmt"
	"slices"
	"strings"
)

/** begin my answer */

/** end my answer */

// add all values in list xs to tree t in order
func addSeq(xs []int, t *TTTree) *TTTree {
	for _, x := range xs {
		t = tttreeAdd(x, t)
	}
	return t
}

func lookupSeq(xs []int, t *TTTree) bool {
	for _, x := range xs {
		if !tttreeLookup(x, t) {
			return false
		}
	}
	return true
}

func removeSeq(xs []int, t *TTTree) *TTTree {
	for _, x := range xs {
		t = tttreeRemove(x, t)
	}
	return t
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

func randomShuffle(seed int, xs []int) []int {
	ys := randomSeq(len(xs), seed)
	ps := make([]Pair, len(xs))
	for i, x := range xs {
		ps[i] = Pair{k: ys[i], x: x}
	}
	slices.SortFunc(ps, func(a, b Pair) int {
		return a.k - b.k
	})
	for i, z := range ps {
		ys[i] = z.x
	}
	return ys
}

func checkSeq(xs0 []int, xs1 []int) bool {
	printSlice("insert in this order: ", xs0, 7)
	printSlice("remove in this order: ", xs1, 7)
	t := addSeq(xs0, nil)
	tttreeCheck(t)
	if lookupSeq(xs1, t) {
		e := removeSeq(xs1, t)
		return e == nil
	} else {
		return false
	}
}

// randomly shuffle 0 .. n-1;
//   add them to empty tree;
//   remove all elements from the tree;
//   check they are sorted

func checkRandom(insertSeed int, removeSeed, n int) bool {
	rng := mkRange(n)
	xs0 := randomShuffle(insertSeed, rng)
	xs1 := randomShuffle(removeSeed, rng)
	return checkSeq(xs0, xs1)
}

func main() {
	insertSeed := 1234
	removeSeed := 123456
	if true {
		if !checkRandom(insertSeed, removeSeed, 2) { panic("wrong") }
		if !checkRandom(insertSeed, removeSeed, 3) { panic("wrong") }
		if !checkRandom(insertSeed + 0, removeSeed + 0, 4) { panic("wrong") }
		if !checkRandom(insertSeed + 1, removeSeed + 1, 4) { panic("wrong") }
		if !checkRandom(insertSeed + 2, removeSeed + 2, 4) { panic("wrong") }
		if !checkRandom(insertSeed + 3, removeSeed + 3, 4) { panic("wrong") }
		if !checkRandom(insertSeed + 0, removeSeed + 0, 5) { panic("wrong") }
		if !checkRandom(insertSeed + 1, removeSeed + 1, 5) { panic("wrong") }
		if !checkRandom(insertSeed + 2, removeSeed + 2, 5) { panic("wrong") }
		if !checkRandom(insertSeed + 3, removeSeed + 3, 5) { panic("wrong") }
		if !checkRandom(insertSeed, removeSeed, 10) { panic("wrong") }
	}
	if !checkRandom(insertSeed, removeSeed, 12) { panic("wrong") }
	if true {
		if !checkRandom(insertSeed, removeSeed, 1000) { panic("wrong") }
		if !checkRandom(insertSeed, removeSeed, 10000) { panic("wrong") }
		if !checkRandom(insertSeed, removeSeed, 100000) { panic("wrong") }
	}
	fmt.Println("OK")
}
