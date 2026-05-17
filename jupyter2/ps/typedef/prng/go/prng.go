package main
import "fmt"

/** begin my answer */

/** begin hidden */
type Prng struct {
	x uint64
}

func mk_prng(seed uint64) Prng {
	return Prng{x: seed}
}

func (rg * Prng) nrand48() uint64 {
	y := (rg.x * 0x5DEECE66D + 0xB) & ((1 << 48) - 1)
	rg.x = y
	return y >> 17
}
/** end hidden */
/** end my answer */
func main() {
	rg := mk_prng(112233445566778899)
	if !(rg.nrand48() == 1781099660) { panic("wrong") }
	if !(rg.nrand48() ==  328479882) { panic("wrong") }
	if !(rg.nrand48() == 1084899894) { panic("wrong") }
	if !(rg.nrand48() == 1228799231) { panic("wrong") }
	if !(rg.nrand48() == 2081468441) { panic("wrong") }
	fmt.Println("OK")
}
