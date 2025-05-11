package main
import "os"

func main() {
    filename := os.Args[1]
    readxml(filename)
    println("OK")
}
