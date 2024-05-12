/*** if 0 */
package main
/*** endif */
/*** if label == "A function" */
func f(x int) int {
    return x + 1
}
/*** endif */
/*** if label == "Apply a function" */
f(3)
/*** endif */
/*** if label == "A recursive function"  */
func fib(n int) int {
    if n < 2 {
        return 1
    } else {
        return fib(n - 1) + fib(n - 2)
    }
}
/*** endif */
/*** if label == "A variable"  */
func fib2(n int) int {
    if n < 2 {
        return 1
    } else {
        x := fib2(n - 1)
        y := fib2(n - 2)
        return x + y
    }
}
/*** endif */
/*** if label == "A data type"  */
type Person struct {
    name string
    date_of_birth string
}
/*** endif */
/*** if label == "Person name"  */
func person_name(p Person) string {
    return p.name
}
/*** endif */
/*** if 0 */
func mk_person() {
    /*** endif */
    /*** if label == "Person name"  */
    person_name(Person{"Masakazu Mimura", "1967/6/8"})
    /*** endif */
    /*** if 0 */
}
/*** endif */
/*** if label == "bintree"  */
type Bintree struct {
    left * Bintree
    right * Bintree
}
/*** endif */
/*** if label == "mk_tree"  */
func mk_tree(n int) * Bintree {
    if n > 0 {
        rc := (n - 1) / 2
        lc := n - 1 - rc
        return &Bintree{mk_tree(lc), mk_tree(rc)}
    } else {
		var p * Bintree = nil
		return p
	}
}
/*** endif */
/*** if label == "count_nodes"  */
func count_nodes(t * Bintree) int {
    if t == nil {
        return 0
    } else {
        return 1 + count_nodes(t.left) + count_nodes(t.right)
    }
}
/*** endif */
/*** if 0 */
func main() {
    /*** endif */
    /*** if label == "1000 nodes"  */
    count_nodes(mk_tree(1000))
    /*** endif */
    /*** if 0 */
}
/*** endif */
