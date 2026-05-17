package main
import "fmt"

/** begin my answer */

/** begin hidden */
type BinTree struct {
	left, right *BinTree
}

func mk_maximally_balanced_bintree(n int) *BinTree {
	if n == 0 {
		return nil
	} else {
		ls := n / 2
		rs := n - 1 - ls
		l := mk_maximally_balanced_bintree(ls)
		r := mk_maximally_balanced_bintree(rs)
		return &BinTree{left: l, right: r}
	}
}

func count_nodes(t *BinTree) int {
	if t == nil {
		return 0
	} else {
		lc := count_nodes(t.left)
		rc := count_nodes(t.right)
		if lc != -1 && rc != -1 && (lc == rc || lc == rc + 1) {
			return 1 + lc + rc
		} else {
			return -1
		}
	}
}

/** end hidden */
/** end my answer */
func main() {
	if !(count_nodes(mk_maximally_balanced_bintree(10))      == 10)      { panic("wrong") }
	if !(count_nodes(mk_maximally_balanced_bintree(100))     == 100)     { panic("wrong") }
	if !(count_nodes(mk_maximally_balanced_bintree(1000))    == 1000)    { panic("wrong") }
	if !(count_nodes(mk_maximally_balanced_bintree(10000))   == 10000)   { panic("wrong") }
	if !(count_nodes(mk_maximally_balanced_bintree(100000))  == 100000)  { panic("wrong") }
	if !(count_nodes(mk_maximally_balanced_bintree(1000000)) == 1000000) { panic("wrong") }
	fmt.Println("OK")
}
