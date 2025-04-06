/*** if 0 */
package main
/*** endif */
/*** if label == "A function" */
func f(a float64, b float64, c float64) float64 {
  return a * a + b * b - c * c
}
/*** endif */
/*** if label == "Apply a function" */
println(f(1,1,1))
println(f(3,4,5))
println(f(2,3,4))
/*** endif */
/*** if label == "Conditional"  */
func mkTriangle(a float64, b float64, c float64) int64 {
    if a + b - c > 0 {
        return 1
    } else {
        return 0
    }
}
/*** endif */
/*** if label == "Test conditional"  */
println(mkTriangle(1, 1, 1))
println(mkTriangle(1, 2, 3))
println(mkTriangle(1, 2, 4))
/*** endif */
/*** if label == "Triangle type"  */
func triangleType(a float64, b float64, c float64) int64 {
    if a + b - c <= 0 {
        return -2
    } else {
        d := a * a + b * b - c * c
        if d < 0 {
            return -1
        } else if d == 0 {
            return 0
        } else {
            return 1
        }
    }
}
/*** endif */
/*** if label == "Test triangle type"  */
println(triangleType(1, 1, 1))
println(triangleType(3, 4, 5))
println(triangleType(3, 4, 6))
println(triangleType(2, 3, 6))
/*** endif */
/*** if label == "GCD"  */
func gcd(a int64, b int64) int64 {
    if a == 0 {
        return b
    } else {
        r := b % a
        return gcd(r, a)
    }
}
/*** endif */
/*** if label == "Test GCD"  */
println(gcd(0, 5))
println(gcd(4, 12))
println(gcd(93, 399))
/*** endif */
/*** if label == "Sum of square"  */
func sum_of_square(n int64) int64 {
    s := int64(0)
    for i := int64(1); i <= n; i++ {
        s += i * i
    }
    return s
}
/*** endif */
/*** if label == "Test sum of square"  */
println(sum_of_square(0))
println(sum_of_square(3))
println(sum_of_square(10))
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
