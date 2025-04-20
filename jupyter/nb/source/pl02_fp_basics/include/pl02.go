/*** if 0 */
package main
import "math"
/*** endif */
/*** if label == "A simple recurrence" */
func a(n int64) float64 {
	if n == 0 {
		return 1
	} else {
		return 0.9 * a(n - 1) + 2
	}
}
/*** endif */
/*** if label == "A simple recurrence test" */
func float64_close(x float64, y float64, eps float64) {
    if math.Abs(x - y) > eps {
        println("NG")
    } else {
        println("OK")
    }
}
/*** if 0 */
func a_test() {
/*** endif */
    float64_close(a(0),   1,          1.0e-6)
    float64_close(a(10),  13.3751096, 1.0e-6)
    float64_close(a(100), 19.9994953, 1.0e-6)
    float64_close(a(300), 20.0,       1.0e-6)
/*** if 0 */
}
/*** endif */
/*** endif */
/*** if label == "The smallest divisor"*/
func smallest_divisor_geq(n int64, x int64) int64 {
    if n % x == 0 {
		return x
    } else if n < x * x {
        return n
    } else {
		return smallest_divisor_geq(n, x + 1) 
	}
}
/*** endif */
/*** if label == "The smallest divisor test" */
func int64_eq(x int64, y int64) {
    if x == y {
        println("OK")
    } else {
        println("NG")
    }
}
/*** if 0 */
func smallest_divisor_geq_test() {
/*** endif */
    int64_eq(smallest_divisor_geq(2,          2), 2)
    int64_eq(smallest_divisor_geq(3,          2), 3)
    int64_eq(smallest_divisor_geq(13 * 17,    2), 13)
    int64_eq(smallest_divisor_geq(6700417, 2), 6700417)
/*** if 0 */
}
/*** endif */
/*** endif */
/*** if label == "Factorize" */
func factorize(n int64) []int64 {
	if n == 1 {
        // an empty slice
		return []int64{}
	} else {
		x := smallest_divisor_geq(n, 2)
		a := factorize(n / x)
		return append([]int64{x}, a...)
	}
}
/*** endif */
/*** if label == "Factorize test" */
func int64_list_eq(a []int64, b []int64) {
    if a == nil && b == nil {
        println("OK")
    } else if a == nil || b == nil {
        println("NG")
    } else if len(a) != len(b) {
        println("NG")
    } else {
        for i := 0; i < len(a); i++ {
            if a[i] != b[i] {
                println("NG")
                return
            }
        }
        println("OK")
    }
}
/*** if 0 */
func factorize_test() {
/*** endif */
    int64_list_eq(factorize(64), []int64{2, 2, 2, 2, 2, 2})
    int64_list_eq(factorize(105), []int64{3, 5, 7})
/*** if 0 */
}
/*** endif */
/*** endif */
/*** if label == "Subset sum" */
func subset_sum(a []int64, v int64) []int64 {
	if v == 0 {
        return make([]int64, len(a))
    }
    if len(a) == 0 {
        return nil
    }
    k1 := subset_sum(a[1:], v - a[0])
    if k1 != nil {
        return append([]int64{1}, k1...)
    }
    k0 := subset_sum(a[1:], v)
    if k0 != nil {
        return append([]int64{0}, k0...)
    }
    return nil
}
/*** endif */
/*** if label == "Subset sum test" */
/*** if 0 */
func subset_sum_test() {
/*** endif */
	int64_list_eq(subset_sum([]int64{1,2,3,4,5}, 8), []int64{1, 1, 0, 0, 1})
    int64_list_eq(subset_sum([]int64{33, 28, 56, 35, 19, 46, 25, 58, 17, 49, 33, 39, 37, 33, 24, 52}, 233),
        []int64{1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0})
    int64_list_eq(subset_sum([]int64{30, 37, 46, 41, 14, 46, 44, 40, 46, 30, 46, 28, 33, 31, 56}, 171),
        []int64{1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0})
    int64_list_eq(subset_sum([]int64{47, 39, 15, 27, 52, 31, 39, 54, 20, 26, 38, 19, 35, 28}, 440), nil)
    int64_list_eq(subset_sum([]int64{16, 24, 13, 20, 24, 13, 11, 31, 29, 44}, 222), nil)
/*** if 0 */
}
/*** endif */
/*** endif */
/*** if 0 */
func main() {
    println("a")
	a_test()
    println("smallest_divisor_geq")
    smallest_divisor_geq_test()
    println("factorize")
	factorize_test()
    println("subset_sum")
    subset_sum_test()
}
/*** endif */
