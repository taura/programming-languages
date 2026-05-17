package main
import (
	"fmt"
	"os"
)

func main() {
	filename := os.Args[1]
	doc := parse(filename)
	d := height(doc.Root)
	fmt.Println(d)
}
