package main
import "fmt"

/** begin my answer */

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
