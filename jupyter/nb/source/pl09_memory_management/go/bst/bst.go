package main
import "fmt"
import "os"
import "strconv"
import "github.com/loov/hrtime"

// ---------- utility ----------

func time_ns() int64 {
	return int64(hrtime.Now())
}

func min(x int64, y int64) int64 {
	if x < y {
		return x
	} else {
		return y
	}
}

func max(x int64, y int64) int64 {
	if x < y {
		return y
	} else {
		return x
	}
}

// allocation record that records how long an allocation took
type Event struct {
	stamp int64		// when it happened
	dt int64		// how long it took
}

// heap data structure that keeps track of longest m allocations
// (this heap should not be confused with heap memory of programming languages).
type EventHeap struct {
	n int64		   // actual no of elements
	a []Event	   // vector of m elements
	// invariant a[p] < a[2p+1], a[p] < a[2p+2]
	start_stamp int64
}

// create a heap of m Events
func mkHeap(m int64) EventHeap {
	return EventHeap{0, make([]Event, m, m), time_ns()}
}

// add an element x to heap h
func (h * EventHeap) add(x Event) {
	n, a := h.n, h.a
	if n >= int64(len(a)) { panic(fmt.Sprintf("n (%d) >= m (%d)", n, len(a))) }
	n = n + 1
	a[n - 1] = x
	c := n - 1
	for c > 0 {
		p := (c - 1) / 2
		if a[c].dt < a[p].dt {
			a[c], a[p] = a[p], a[c]
		}
		c = p
	}
	h.n = n
}

// remove the smallest element from h
func (h * EventHeap) removeSmallest() Event {
	n, a := h.n, h.a
	if n <= 0 { panic(fmt.Sprintf("n (%d) <= 0", n)) }
	x := a[0]
	a[0] = a[n - 1]
	n = n - 1
	var p int64 = 0
	for 2 * p + 1 < n {
		l := 2 * p + 1
		r := 2 * p + 2
		var c int64
		if r < n && a[r].dt < a[l].dt {
			c = r
		} else {
			c = l
		}
		if a[c].dt < a[p].dt {
			a[c], a[p] = a[p], a[c]
		}
		p = c
	}
	h.n = n
	return x
}

// if h has a room for another element, insert Event(no, stamp, dt)
// otherwise if dt is larger than the smallest dt in h, then
// replace it with Event(no, stamp, dt)
func (h * EventHeap) addRecord(dt int64) {
	m := int64(len(h.a))
	if h.n == m && h.a[0].dt < dt { h.removeSmallest() }
	if h.n < m {
		stamp := time_ns() - h.start_stamp
		h.add(Event{stamp, dt})
	}
}

// debugprint heap
func (h * EventHeap) printHeap(filename string) {
	wp, err := os.Create(filename)
	if err != nil { panic("could not create go.log") }
	defer wp.Close()
	// fmt.Fprintf(wp, "stamp,dt\n")
	n := h.n
	for i := int64(0); i < n; i++ {
		e := h.removeSmallest()
		fmt.Fprintf(wp, "%d,%d\n", e.stamp, e.dt)
	}
}

// random number generator state
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

// binary search tree
type BinSearchTree struct {
	val uint64
	left * BinSearchTree
	right * BinSearchTree
}

// insert x to a tree
func (t * BinSearchTree) insert(x uint64) * BinSearchTree {
	if t == nil {
		return &BinSearchTree{x, nil, nil}
	} else if x <= t.val {
		return &BinSearchTree{t.val, t.left.insert(x), t.right}
	} else {
		return &BinSearchTree{t.val, t.left, t.right.insert(x)}
	}
}

// remove the maximum element from a tree
func (t * BinSearchTree) remove_max() * BinSearchTree {
	if t == nil {
		return nil
	} else if t.right == nil {
		return t.left
	} else {
		return &BinSearchTree{t.val, t.left, t.right.remove_max()}
	}
}

// find the maximum element of a tree
func (t * BinSearchTree) peek_max() uint64 {
	if t.right == nil {
		return t.val
	} else {
		return t.right.peek_max()
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
	n_records := get_int64(os.Args, 3, max(n / 1000, int64(100)))
	rg := RandState{123456}
	println("make a tree of m =", m, "nodes")
	var t * BinSearchTree = nil
	for i := int64(0); i < m; i++ {
		x := rg.next() % 1000000000;
		t = t.insert(x);
	}
	println("insert/delete n =", n, "times")
	h := mkHeap(n_records)
	t0 := time_ns();
	for i := int64(0); i < n; i++ {
		x := rg.next() % 1000000000;
		s0 := time_ns();
		t = t.insert(x);
		t = t.remove_max();
		s1 := time_ns();
		h.addRecord(s1 - s0)
	}
	t1 := time_ns();
	if t == nil {
		println()
	} else {
		v := t.peek_max()
		println(m, "th smallest value out of", (m + n), "values v =", v)
	}
	println("took", (t1 - t0), "nsec to insert/remove", n, "elements")
	alloc_log := "allocation-go.csv"
	println("dump", n_records, "records that took longest to", alloc_log)
	h.printHeap(alloc_log)
}

