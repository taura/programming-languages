package main

import (
	"fmt"
	"slices"
)

/** begin my answer */
/** begin hidden */
type BinHeap struct {
	x  int
	lc int
	l  *BinHeap
	rc int
	r  *BinHeap
}

func completeBinaryTree(n int) bool {
	return (n & (n + 1)) == 0
}

func binHeapAdd(x int, t *BinHeap) *BinHeap {
	if t == nil {
		return &BinHeap{x: x, lc: 0, l: nil, rc: 0, r: nil}
	} else {
		if !(t.lc >= t.rc) { panic("assert lc >= rc") }
		u, v := min(x, t.x), max(x, t.x)
		if completeBinaryTree(t.lc) && t.lc > t.rc {
			// left is perfect; add to right
			return &BinHeap{x: u, lc: t.lc, l: t.l, rc: t.rc + 1, r: binHeapAdd(v, t.r)}
		} else {
			// add to left
			return &BinHeap{x: u, lc: t.lc + 1, l: binHeapAdd(v, t.l), rc: t.rc, r: t.r}
		}
	}
}

func binHeapRemoveRightmostLeaf(t *BinHeap) (int, *BinHeap) {
	if t == nil {
		return -1, nil
	} else if t.lc == 0 && t.rc == 0 {
		return t.x, nil
	} else if completeBinaryTree(t.lc) && t.lc < 2*t.rc+1 {
		// remove from right
		y, r_ := binHeapRemoveRightmostLeaf(t.r)
		if y == -1 { panic("assert y != -1") }
		return y, &BinHeap{x: t.x, lc: t.lc, l: t.l, rc: t.rc - 1, r: r_}
	} else {
		// remove from left
		y, l_ := binHeapRemoveRightmostLeaf(t.l)
		return y, &BinHeap{x: t.x, lc: t.lc - 1, l: l_, rc: t.rc, r: t.r}
	}
}
    
func binHeapFix(t *BinHeap) *BinHeap {
	if t == nil {
		return nil
	} else if t.lc == 0 && t.rc == 0 {
		return t
	} else if t.lc == 1 && t.rc == 0 {
		u, v := min(t.x, t.l.x), max(t.x, t.l.x)
		return &BinHeap{x: u, lc: 1, l: &BinHeap{x: v, lc: 0, l: nil, rc: 0, r: nil}, rc: 0, r: nil}
	} else {
		lx := t.l.x
		rx := t.r.x
		if t.x < lx && t.x < rx {
			// x is already root
			return t
		} else if lx < rx {
			// lx should be root x <-> lx
			return &BinHeap{x: lx,
				lc: t.lc, l: binHeapFix(&BinHeap{x: t.x, lc: t.l.lc, l: t.l.l, rc: t.l.rc, r: t.l.r}),
				rc: t.rc, r: t.r}
		} else {
			// rx should root x <-> ly
			return &BinHeap{x: rx,
				lc: t.lc, l: t.l,
				rc: t.rc, r: binHeapFix(&BinHeap{x: t.x, lc: t.r.lc, l: t.r.l, rc: t.r.rc, r: t.r.r})}
		}
	}
}

func binHeapRemoveMin(t *BinHeap) (int, *BinHeap) {
	x, t := binHeapRemoveRightmostLeaf(t)
	if x == -1 {
		return -1, nil
	} else if t == nil {
		return x, nil
	} else {
		return t.x, binHeapFix(&BinHeap{x: x, lc: t.lc, l: t.l, rc: t.rc, r: t.r})
	}
}

/** end hidden */
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
