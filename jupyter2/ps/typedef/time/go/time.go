package main
import "fmt"

/** begin my answer */

/** begin hidden */
type Time struct {
	hour, minute int
	second float64
}

func secondOfTime (t Time) float64 {
	return float64(t.hour) * 3600 + float64(t.minute) * 60 + t.second
}

func timeDiff (a, b Time) float64 {
	return secondOfTime(a) - secondOfTime(b)
}
/** end hidden */
/** end my answer */
func main() {
	if !((timeDiff(Time{hour: 12, minute: 0, second: 0.0}, Time{hour: 11, minute: 30, second: 0.0}) - 1800.0) < 1e-6) { panic("wrong") }
	if !((timeDiff(Time{hour: 23, minute: 59, second: 59.9}, Time{hour: 0, minute: 0, second: 0.0}) - 86399.9) < 1e-6) { panic("wrong") }
	fmt.Println("OK")
}
