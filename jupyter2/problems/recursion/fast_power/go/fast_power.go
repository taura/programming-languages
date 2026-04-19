package main
import (
	"math"
	"fmt"
)

func power_iter(a float64, n int64) float64 {
	p := 1.0
	for i := int64(0); i < n; i++ {
		p *= a
	}
	return p
}
/** begin my answer */

/** end my answer */

func main() {
	if !(math.Abs(power_simple(1.0 + 1.0/10.0,      10)        - 2.59374246) < 1.0e-7) { panic("wrong") }
	if !(math.Abs(power_fast(1.0 + 1.0/10.0,        10)        - 2.59374246) < 1.0e-7) { panic("wrong") }
	if !(math.Abs(power_simple(1.0 + 1.0/100.0,     100)       - 2.70481383) < 1.0e-7) { panic("wrong") }
	if !(math.Abs(power_fast(1.0 + 1.0/100.0,       100)       - 2.70481383) < 1.0e-7) { panic("wrong") }
	if !(math.Abs(power_fast(1.0 + 1.0/1000000.0,   1000000)   - 2.71828047) < 1.0e-7) { panic("wrong") }
	if !(math.Abs(power_iter(1.0 + 1.0/1000000.0,   1000000)   - 2.71828047) < 1.0e-7) { panic("wrong") }
	if !(math.Abs(power_fast(1.0 + 1.0/10000000.0,  10000000)  - 2.71828169) < 1.0e-7) { panic("wrong") }
	if !(math.Abs(power_iter(1.0 + 1.0/10000000.0,  10000000)  - 2.71828169) < 1.0e-7) { panic("wrong") }
	if !(math.Abs(power_fast(1.0 + 1.0/100000000.0, 100000000) - 2.71828179) < 1.0e-7) { panic("wrong") }
	if !(math.Abs(power_iter(1.0 + 1.0/100000000.0, 100000000) - 2.71828180) < 1.0e-7) { panic("wrong") }
	fmt.Println("OK")
}
