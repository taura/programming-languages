/*** if 0 */ 
package main

import (
    "fmt"
    "math/rand"
)
/*** endif */ 
/*** if label == "A generic T -> float minimizer" */
// does not work on Jupyter (use command line)
type Generator [T any] interface {
    next() (T, bool)
}

func minimize [T any] (f func (T) float64,
    rg Generator[T]) (T, float64, bool) {
    var min_x T
    var min_y float64
    i := 0
    for {
        x, some := rg.next()
        if ! some { break }
        y := f(x)
        if i == 0 || y < min_y {
            min_y = y
            min_x = x
        }
        i += 1
    }
    return min_x, min_y, i > 0
}
/*** endif */ 
/*** if label == "Apply a generic T -> float minimizer" */
// does not work on Jupyter (use command line)
type EllipseGenerator struct {
    x0, y0, a, b float64
    n int
    i int
    rng * rand.Rand
}

func mk_ellipse_generator(x0, y0, a, b float64, n int) * EllipseGenerator {
    rng := rand.New(rand.NewSource(123456));
    return &EllipseGenerator{x0, y0, a, b, n, 0, rng};
}

func (eg * EllipseGenerator) next() ([2]float64, bool) {
    if eg.i < eg.n {
        for {
            rx := -1 + 2 * eg.rng.Float64()
            ry := -1 + 2 * eg.rng.Float64()
            if rx * rx + ry * ry < 1.0 {
                x := eg.x0 + rx * eg.a
                y := eg.y0 + ry * eg.b
                eg.i += 1
                return [2]float64{x, y}, true
            }
        }
    } else {
        return [2]float64{0.0, 0.0}, false;
    }
}

func main() {
    f := func (xy [2]float64) float64 {
        x := xy[0]
        y := xy[1]
        return x * x + y * y
    }
    rg := mk_ellipse_generator(3.0, 3.0, 2.0, 1.0, 10000)
    xy, z, some := minimize[[2]float64](f, rg)
    if some {
        fmt.Printf("%f %f %f\n", xy[0], xy[1], z);
    } else {
        fmt.Printf("\n");
    }
}
/*** endif */ 
