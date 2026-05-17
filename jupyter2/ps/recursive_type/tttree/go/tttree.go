package main
import (
	"fmt"
	"slices"
	"strings"
)

/** begin my answer */

/** begin hidden */
// non-empty two-three-tree
// leaf : length(keys) == 1, children == nil
// N2 : length(keys) == 1, length(children) == 2
// N3 : length(keys) == 2, length(children) == 3
type TTTree_ struct {
	keys []int
	children []*TTTree_
}

func leaf(x int) *TTTree_ {
	return &TTTree_{keys: []int{x}, children: nil}
}

func n2(u0 *TTTree_, s0 int, u1 *TTTree_) *TTTree_ {
	return &TTTree_{keys: []int{s0}, children: []*TTTree_{u0, u1}}
}

func n3(u0 *TTTree_, s0 int, u1 *TTTree_, s1 int, u2 *TTTree_) *TTTree_ {
	return &TTTree_{keys: []int{s0, s1}, children: []*TTTree_{u0, u1, u2}}
}

func isLeaf(t *TTTree_) bool {
	return t.children == nil
}

// empty : nil
// singleton : t = nil
// tree : t != nil
type TTTree struct {
	key int
	t *TTTree_
}

func singleton(x int) *TTTree {
	return &TTTree{key: x, t: nil}
}

func tree(t *TTTree_) *TTTree {
	return &TTTree{t: t}
}

func isEmpty(t *TTTree) bool {
	return t == nil
}

func isSingleton(t *TTTree) bool {
	return t.t == nil
}

/* check if all leaves have the same depth and all internal nodes have the correct number of children (2 or 3)
   and returns the depth of the tree if it is a valid two-three-tree */
func tttreeCheck_(t *TTTree_) int {
	if isLeaf(t) {		// leaf
		return 0
	} else {
		n := len(t.children)
		d := tttreeCheck_(t.children[0])
		for i := 1; i < n; i++ {
			d_ := tttreeCheck_(t.children[i])
			if d_ != d { panic("assert all children have the same depth") }
		}
		return d + 1
	}
}

func _tttreeCheck(t *TTTree) int {
	if isEmpty(t){		// empty
		return 0
	} else if isSingleton(t) { // singleton
		return 1
	} else {			// tree
		return tttreeCheck_(t.t)
	}
}

func tttreePrint_(t *TTTree_, depth int) int {
	if isLeaf(t) {
		fmt.Print(strings.Repeat(" ", depth), "Leaf(", t.keys[0], ")\n")
		return 0
	} else {
		fmt.Print(strings.Repeat(" ", depth), "Node(");
		n := len(t.children)
		for i := 0; i < n - 1; i++ {
			if i > 0 {
				fmt.Print("|")
			}
			fmt.Print(t.keys[i])
		}
		fmt.Print(") [\n")
		d := tttreePrint_(t.children[0], depth + 1)
		for i := 1; i < n; i++ {
			d_ := tttreePrint_(t.children[i], depth + 1)
			if d_ != d { panic("assert all children have the same depth") }
		}
		fmt.Print(strings.Repeat(" ", depth), "]\n");
		return d + 1
	}
}

func tttreeCheck(t *TTTree) int {
	if isEmpty(t) {
		//fmt.Println("Empty")
		return 0
	} else if isSingleton(t) {
		//fmt.Println("Singleton(", t.key, ")")
		return 1
	} else {
		return tttreeCheck_(t.t)
	}
}

// return
// (nil, c0, s0, c1) or 
// (t', nil, -1, nil)
func tttreeAdd_(x int, t *TTTree_) (*TTTree_, *TTTree_, int, *TTTree_) {
	if isLeaf(t) {
		y := t.keys[0]
		u, v := min(x, y), max(x, y)
		return nil, leaf(u), v, leaf(v)
	} else if len(t.children) == 2 {
		//    s0
		// u0    u1
		s0 := t.keys[0]
		u0, u1 := t.children[0], t.children[1]
		if x < s0 {
			u0_, u00, s00, u01 := tttreeAdd_(x, u0)
			if u0_ == nil {
				//     s00     s0 
				// u00     u01    u1
				return n3(u00, s00, u01, s0, u1), nil, -1, nil
			} else {
				return n2(u0_, s0, u1), nil, -1, nil
			}
		} else {
			u1_, u10, s10, u11 := tttreeAdd_(x, u1)
			if u1_ == nil {
				//    s0     s10
				// u0    u10     u11
				return n3(u0, s0, u10, s10, u11), nil, -1, nil
			} else {
				return n2(u0, s0, u1_), nil, -1, nil
			}
		}
	} else if len(t.children) == 3 {
		s0, s1 := t.keys[0], t.keys[1]
		u0, u1, u2 := t.children[0], t.children[1], t.children[2]
		if x < s0 {
			u0_, u00, s00, u01 := tttreeAdd_(x, u0)
			if u0_ == nil {
				//     s00
				// u00     s0     s1
				//     u01     u1    u2
				return nil, n2(u00, s00, u01), s0, n2(u1, s1, u2)
			} else {
				return n3(u0_, s0, u1, s1, u2), nil, -1, nil
			}
		} else if x < s1 {
			u1_, u10, s10, u11 := tttreeAdd_(x, u1)
			if u1_ == nil {
				//    s0     s10      s1
				// u0    u10      u11    u2
				return nil, n2(u0, s0, u10), s10, n2(u11, s1, u2)
			} else {
				return n3(u0, s0, u1_, s1, u2), nil, -1, nil
			}
		} else {
			u2_, u20, s20, u21 := tttreeAdd_(x, u2)
			if u2_ == nil {
				//    s0    s1     s21
				// u0    u1    u20     u21
				return nil, n2(u0, s0, u1), s1, n2(u20, s20, u21)
			} else {
				return n3(u0, s0, u1, s1, u2_), nil, -1, nil
			}
		}
	} else {
		panic("assert invalid node")
	}
}

func tttreeAdd(x int, t *TTTree) *TTTree {
	if isEmpty(t) {
		return singleton(x)
	} else if isSingleton(t) {
		y := t.key
		u, v := min(x, y), max(x, y)
		return tree(n2(leaf(u), v, leaf(v)))
	} else {
		t_, t0, s0, t1 := tttreeAdd_(x, t.t)
		if t_ == nil {
			return tree(n2(t0, s0, t1))
		} else {
			return tree(t_)
		}
	}
}

func tttreeLookup_(x int, t *TTTree_) bool {
	if isLeaf(t) {
		return x == t.keys[0]
	} else {
		n := len(t.children)
		for i := 0; i < n - 1; i++ {
			if x < t.keys[i] {
				return tttreeLookup_(x, t.children[i])
			}
		}
		return tttreeLookup_(x, t.children[n - 1])
	}
}

func tttreeLookup(x int, t *TTTree) bool {
	if isEmpty(t) {
		return false
	} else if isSingleton(t) {
		return x == t.key
	} else {
		return tttreeLookup_(x, t.t)
	}
}

// return (nil, nil) if t becomes empty after removing x
// return (nil, c0) if t becomes a single-child node whose sole child is c0
// return (t', nil) if t remains a valid node having 2 or 3 children after removing x
func tttreeRemove_(x int, t *TTTree_) (*TTTree_, *TTTree_) {
	if isLeaf(t) {
		if x == t.keys[0] {
			return nil, nil // empty
		} else {
			return t, nil // unchanged
		}
	} else if len(t.children) == 2 {
		//    s0
		// u0    u1
		s0 := t.keys[0]
		u0, u1 := t.children[0], t.children[1]
		if x < s0 {
			u0_, u00 := tttreeRemove_(x, u0)
			if u0_ == nil && u00 == nil {
				// t becomes single-child node
				return nil, u1
			} else if u0_ == nil {
				//      s0
				//  u0_     u1
				//   |
				//  u00
				if len(u1.children) == 2 {
					//      s0
					//  u0_    u1
					//   |     / \
					//  u00  u10 u11
					s10 := u1.keys[0]
					u10, u11 := u1.children[0], u1.children[1]
					return nil, n3(u00, s0, u10, s10, u11)
				} else if len(u1.children) == 3 {
					//      s0
					//  u0_    u1
					//   |     /|\
					//  u00  u10u11u12
					s10, s11 := u1.keys[0], u1.keys[1]
					u10, u11, u12 := u1.children[0], u1.children[1], u1.children[2]
					return n2(n2(u00, s0, u10), s10, n2(u11, s11, u12)), nil
				} else {
					panic("assert invalid node")
				}
			} else {
				return n2(u0_, s0, u1), nil
			}
		} else {
			u1_, u10 := tttreeRemove_(x, u1)
			if u1_ == nil && u10 == nil {
				return nil, u0
			} else if u1_ == nil {
				//    s0
				// u0    u1_
				//        |
				//       u10
				if len(u0.children) == 2 {
					//    s0
					// u0    u1_
					// /\     |
					//u00u01  u10
					s00 := u0.keys[0]
					u00, u01 := u0.children[0], u0.children[1]
					return nil, n3(u00, s00, u01, s0, u10)
				} else if len(u0.children) == 3 {
					//      s0
					//   u0     u1_
					//  /|\     |
					//u00u01u02 u10
					s00, s01 := u0.keys[0], u0.keys[1]
					u00, u01, u02 := u0.children[0], u0.children[1], u0.children[2]
					return n2(n2(u00, s00, u01), s01, n2(u02, s0, u10)), nil
				} else {
					panic("assert invalid node")
				}
			} else {
				return n2(u0, s0, u1_), nil
			}
		}
	} else if len(t.children) == 3 {
		//    s0    s1
		// u0    u1    u2
		s0, s1 := t.keys[0], t.keys[1]
		u0, u1, u2 := t.children[0], t.children[1], t.children[2]
		if x < s0 {
			u0_, u00 := tttreeRemove_(x, u0)
			if u0_ == nil && u00 == nil {
				return n2(u1, s1, u2), nil
			} else if u0_ == nil {
				//    s0    s1
				// u0    u1    u2
				//  |
				// u00
				if len(u1.children) == 2 {
					//    s0     s1
					// u0     u1     u2
					//  |     / \
					// u00   u10 u11
					s10 := u1.keys[0]
					u10, u11 := u1.children[0], u1.children[1]
					return n2(n3(u00, s0, u10, s10, u11), s1, u2), nil
				} else if len(u1.children) == 3 {
					//    s0     s1
					// u0     u1     u2
					//  |     /|\
					// u00  u10u11u12
					s10, s11 := u1.keys[0], u1.keys[1]
					u10, u11, u12 := u1.children[0], u1.children[1], u1.children[2]
					return n3(n2(u00, s0, u10), s10, n2(u11, s11, u12), s1, u2), nil
				} else {
					panic("assert invalid node")
				}
			} else {
				return n3(u0_, s0, u1, s1, u2), nil
			}
		} else if x < s1 {
			u1_, u10 := tttreeRemove_(x, u1)
			if u1_ == nil && u10 == nil {
				return n2(u0, s0, u2), nil
			} else if u1_ == nil {
				//     s0    s1
				// u0    u1    u2
				//       |
				//      u10
				if len(u0.children) == 2 {
					//     s0    s1
					// u0    u1    u2
					// /\     |
					//u00u01  u10
					s00 := u0.keys[0]
					u00, u01 := u0.children[0], u0.children[1]
					return n2(n3(u00, s00, u01, s0, u10), s1, u2), nil
				} else if len(u0.children) == 3 {
					//      s0     s1
					//   u0     u1    u2
					//  /|\     |
					//u00u01u02 u10
					s00, s01 := u0.keys[0], u0.keys[1]
					u00, u01, u02 := u0.children[0], u0.children[1], u0.children[2]
					return n3(n2(u00, s00, u01), s01, n2(u02, s0, u10), s1, u2), nil
				} else {
					panic("assert invalid node")
				}
			} else {
				return n3(u0, s0, u1_, s1, u2), nil
			}
		} else {
			u2_, u20 := tttreeRemove_(x, u2)
			if u2_ == nil && u20 == nil {
				return n2(u0, s0, u1), nil
			} else if u2_ == nil {
				//     s0    s1
				// u0    u1    u2
				//             |
				//            u20
				if len(u1.children) == 2 {
					//     s0    s1
					// u0    u1    u2
					//       /\     |
					//     u10u11  u20
					s10 := u1.keys[0]
					u10, u11 := u1.children[0], u1.children[1]
					return n2(u0, s0, n3(u10, s10, u11, s1, u20)), nil
				} else if len(u1.children) == 3 {
					//      s0     s1
					//   u0     u1     u2
					//         /|\     |
					//      u10u11u12  u20
					s10, s11 := u1.keys[0], u1.keys[1]
					u10, u11, u12 := u1.children[0], u1.children[1], u1.children[2]
					return n3(u0, s0, n2(u10, s10, u11), s11, n2(u12, s1, u20)), nil
				} else {
					panic("assert invalid node")
				}
			} else {
				return n3(u0, s0, u1, s1, u2_), nil
			}
		}
	} else {
		panic("assert invalid node")
	}
}

func tttreeRemove(x int, t *TTTree) *TTTree {
	if isEmpty(t) {
		return nil
	} else if isSingleton(t) {
		if x == t.key {
			return nil
		} else {
			return t
		}
	} else {
		t_, c0 := tttreeRemove_(x, t.t)
		if t_ == nil && c0 == nil {
			return nil
		} else if t_ == nil {
			if c0.children == nil {
				return singleton(c0.keys[0])
			} else {
				return tree(c0)
			}
		} else {
			return tree(t_)
		}
	}
}

/** end hidden */
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
