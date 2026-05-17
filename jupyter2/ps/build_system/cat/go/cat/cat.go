/* go/cat/cat.go */
package main
import (
	"fmt"
	"os"
)

func main() {
	// get command line arguments
	filename := os.Args[1]
	// read file
	content, err := os.ReadFile(filename)
	if err != nil {
		fmt.Println("Error reading file:", err)
		return
	}
	// print content to stdout
	fmt.Print(string(content))
}
