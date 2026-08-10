package main
import (
    "os"
    "strconv"
    "fmt"
    "github.com/loov/hrtime"
)

func get_int64(args []string, i int, def_val int64) int64 {
	if i < len(args)  {
		x, _ := strconv.Atoi(args[i])
		return int64(x)
	} else {
		return def_val
	}
}

func time_ns() int64 {
	return int64(hrtime.Now())
}

func main() {
	s := get_int64(os.Args, 1, int64(1000 * 1000))
	m := get_int64(os.Args, 2, int64(10))
	n := get_int64(os.Args, 3, m * 10)
	sizeof_int64 := int64(8)
	if sizeof_int64 * s * m > (1 << 30) {
		fmt.Fprintf(os.Stderr, "you'd better not allocate that much memory\n")
		fmt.Fprintf(os.Stderr, "sizeof(int64)(8) * s(%d) * m(%d) = %d > 1GB\n", s, m, sizeof_int64 * s * m)
		os.Exit(1)
	}
	a := make([][]int64, m)
	for i := int64(0); i < n; i++ {
		t0 := time_ns()
		b := make([]int64, s)
		t1 := time_ns()
		for j := range b { b[j] = i }
		a[i % m] = b
		fmt.Printf("%d %d %d\n", i, &b[0], t1 - t0)
	}
}

