package main
import (
    "os"
    "strconv"
    "fmt"
/*** if label == "measure_time" */
    "github.com/loov/hrtime"
/*** endif */
)

func get_int64(args []string, i int, def_val int64) int64 {
	if i < len(args)  {
		x, _ := strconv.Atoi(args[i])
		return int64(x)
	} else {
		return def_val
	}
}

/*** if label == "measure_time" */
func time_ns() int64 {
	return int64(hrtime.Now())
}
/*** endif */

func main() {
	s := get_int64(os.Args, 1, int64(1000 * 1000))
	m := get_int64(os.Args, 2, int64(100))
	n := get_int64(os.Args, 3, m * 10)
    sizeof_elem := int64(8)
    if sizeof_elem * s * m > (1 << 30) {
        fmt.Printf("you'd better not allocate that much memory\n")
        fmt.Printf("sizeof_element(8) * s(%d) * m(%d) = %d > 1GB\n", s, m, sizeof_elem * s * m)
        os.Exit(1)
    }
    a := make([][]int64, m)
    for i := int64(0); i < n; i++ {
/*** if label == "measure_time" */
        t0 := time_ns()
/*** endif */
        b := make([]int64, s)
        a[i % m] = b
/*** if label == "show_addr" */
        fmt.Printf("%d\t%d\n", i, &b[0])
/*** endif */
/*** if label == "measure_time" */
        t1 := time_ns()
        fmt.Printf("%d\t%d\t%d\n", i, &b[0], t1 - t0)
/*** endif */
    }
}
