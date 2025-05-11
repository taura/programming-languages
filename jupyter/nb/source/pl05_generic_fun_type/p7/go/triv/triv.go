package main

type triv[T any] struct {
    x T
}

func triv_val[T any](t triv[T]) T {
    return t.x
}

func main() {
    s := triv[int]{3}
    x := triv_val(s)
    t := triv[string]{"hello"}
    y := triv_val(t)
    println(x)
    println(y)
}
