package main
import "fmt"

/** begin my answer */

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
