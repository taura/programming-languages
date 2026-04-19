package main
import "fmt"

/** begin my answer */

/** end my answer */

func main() {
	if !(gcd(1499276220,   463728183)   == 6873) { panic("wrong") }
	if !(gcd(256381708674, 48941846742) == 35094) { panic("wrong") }
	if !(gcd(8619803849,   3861314192)  == 11437) { panic("wrong") }
	fmt.Println("OK")
}
