package main
import "os"
import "github.com/subchen/go-xmldom"

func main() {
    filename := os.Args[1]
    _, err := xmldom.ParseFile(filename)
    if err != nil {
        panic(err)
    }
    println("OK")
}
