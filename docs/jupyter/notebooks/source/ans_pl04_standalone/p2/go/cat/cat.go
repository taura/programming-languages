package main
import "os"

func main() {
    filename := os.Args[1]
    dat, err := os.ReadFile(filename)
    if err != nil {
        panic(err)
    }
    print(string(dat))
}
