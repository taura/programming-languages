package main
import "fmt"
import "os"
import "strconv"
import "github.com/loov/hrtime"

// ---------- utility ----------

func time_ns() int64 {
	return int64(hrtime.Now())
}

// ---------- random number generator state ----------
type RandState struct {
    x  uint64
}

// next number
func (rg * RandState) next() uint64 {
	x := rg.x
	var a uint64 = 0x5DEECE66D
	var c uint64 = 0xB
	var m uint64 = (uint64(1) << 48) - 1
	rg.x = (a * x + c) & m
	return rg.x >> 17
}

// ---------- binary search tree ----------
type BinSearchTree struct {
	val uint64
	lc uint64
	left * BinSearchTree
	rc uint64
	right * BinSearchTree
}

// insert x to a tree
func (t * BinSearchTree) insert(x uint64) * BinSearchTree {
	if t == nil {
		return &BinSearchTree{x, 0, nil, 0, nil}
	} else if x <= t.val {
		return &BinSearchTree{t.val, t.lc + 1, t.left.insert(x), t.rc, t.right}
	} else {
		return &BinSearchTree{t.val, t.lc, t.left, t.rc + 1, t.right.insert(x)}
	}
}

// remove the nth element in the tree (0-based), and return the removed value and the new tree
func (t * BinSearchTree) remove_nth(n uint64) (uint64, * BinSearchTree) {
	if t == nil {
		panic("remove_nth : empty tree")
	} else if n < t.lc {
		val, left_ := t.left.remove_nth(n)
		return val, &BinSearchTree{t.val, t.lc - 1, left_, t.rc, t.right}
	} else if n == t.lc {
		if t.lc < t.rc {
			val, right_ := t.right.remove_nth(0)
			return t.val, &BinSearchTree{val, t.lc, t.left, t.rc - 1, right_}
		} else if t.left != nil {
			val, left_ := t.left.remove_nth(t.lc - 1)
			return t.val, &BinSearchTree{val, t.lc - 1, left_, t.rc, t.right}
		} else {
			return t.val, nil
		}
	} else {
		val, right_ := t.right.remove_nth(n - t.lc - 1)
		return val, &BinSearchTree{t.val, t.lc, t.left, t.rc - 1, right_}
	}
}

// dump first n elements in the tree (0-based)
func (t * BinSearchTree) dump(n uint64) {
	if t != nil && n > 0 {
		t.left.dump(n)
		if t.lc < n {
			fmt.Printf("%d ", t.val)
			if t.lc + 1 < n {
				t.right.dump(n - t.lc - 1)
			}
		}
	}
}

func get_int64(args []string, i int, def_val int64) int64 {
	if i < len(args)  {
		x, _ := strconv.Atoi(args[i])
		return int64(x)
	} else {
		return def_val
	}
}

func main() {
	println("lang = go")
	m := get_int64(os.Args, 1, int64(100 * 1000))
	n := get_int64(os.Args, 2, m / 2)
	rg := RandState{123456}
	println("make a tree of m =", m, "nodes")
	var t * BinSearchTree = nil
	var _ uint64 = 0
	for i := int64(0); i < m; i++ {
		x := rg.next() % 1000000000
		//fmt.Printf("insert %d %d\n", i, x)
		t = t.insert(x)
	}
	println("insert/delete n =", n, "times")
	t0 := time_ns();
	for i := int64(0); i < n; i++ {
		x := rg.next() % 1000000000
		k := rg.next() % uint64(m + 1)
		t = t.insert(x)
		_, t = t.remove_nth(k)
	}
	t1 := time_ns()
	fmt.Print("dump the first 5 elements in the tree : ")
	t.dump(5)
	fmt.Println()
	fmt.Printf("took %d nsec to insert/remove %d elements (%f nsec/elem)\n", (t1 - t0), n, float64(t1 - t0) / float64(n))
}

