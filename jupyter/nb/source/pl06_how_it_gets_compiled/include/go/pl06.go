/*** if 1 */
package pl06
/*** endif */
/*** if label == "add123" */
func Add123(x int64) int64 {
    return x + 123;
}
/*** endif */
/*** if label == "many_args" */
func Many_args(a00 int64, a01 int64, a02 int64, a03 int64, a04 int64, a05 int64,
    a06 int64, a07 int64, a08 int64, a09 int64, a10 int64, a11 int64) int64 {
    return a00 + a01 + a02 + a03 + a04 + a05 + a06 + a07 + a08 + a09 + a10 + a11
}
/*** endif */
/*** if label == "add_floats" */
func Add_floats(x float64, y float64) float64 {
    return x + y
}
/*** endif */
/*** if label == "get_float_array_elem" */
func Get_float_array_elem_const(a []float64) float64 {
    return a[2]
}
func Get_float_array_elem_i(a []float64, i int64) float64 {
    return a[i]
}
/*** endif */
/*** if label == "get_struct_elem" */
type Point struct {
    x float64
    y float64
}
func Get_point_y(p Point) float64 {
    return p.y
}
func Get_pointp_y(p * Point) float64 {
    return p.y
}
/*** endif */
/*** if label == "collatz" */
func Collatz(n int64) int64 {
    if n % 2 == 0 {
        return n / 2
    } else {
        return 3 * n + 1
    }
}
/*** endif */
/*** if label == "call" */
func Call_f(x float64) float64 {
    return math.Sqrt(x + 1)
}
func tautautau(n int64, m int64) int64 {
    return n / m
}
/*** endif */
/*** if label == "regions" */
func Regions(n int64) int64 {
    if n == 0 {
        return 1
    } else {
        return Regions(n - 1) + n - 1
    }
}
/*** endif */
/*** if label == "sum_array_rec" */
func Sum_array_rec(a []float64, p int64, q int64) float64 {
    if (q - p == 0) {
        return 0.0
    } else if (q - p == 1) {
        return a[p]
    } else {
        r := (p + q) / 2
        return Sum_array_rec(a, p, r) + Sum_array_rec(a, r, q)
    }
}
/*** endif */
/*** if label == "regions_tail" */
func Regions_tail(i int64, n int64, ri int64) int64 {
    if i == n {
        return ri
    } else {
        riplus1 := ri + i + 1
        return Regions_tail(i + 1, n, riplus1)
    }
}
/*** endif */
/*** if label == "sum_array_tail_rec" */
func Sum_array_tail_rec(a []float64, i int64, n int64, s float64) float64 {
    if i == n {
        return s
    } else {
        return Sum_array_tail_rec(a, i + 1, n, s + a[i])
    }
}
/*** endif */
/*** if label == "sum_array_loop" */
func Sum_array_loop(a []float64, n int64) float64 {
    s := 0.0
    var i int64;
    for i = 0; i < n; i++ {
        s += a[i]
    }
    return s;
}
/*** endif */
/*** if 0 */
func main() {
    
}
/*** endif */
