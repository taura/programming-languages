/*** if 0 */ 
package main

import (
        "fmt"
        "math/rand"
)
/*** endif */ 
/*** if label == "A domain class for a floating point number"  */
type RandomFloatGenerator struct {
        a, b float64
        n int
        i int
        rng * rand.Rand
}

func mk_random_float_generator(a float64, b float64, n int) * RandomFloatGenerator {
        rng := rand.New(rand.NewSource(123456));
        return &RandomFloatGenerator{a, b, n, 0, rng};
}

func (rfg * RandomFloatGenerator) next() (float64, bool) {
        if rfg.i < rfg.n {
                x := rfg.a + (rfg.b - rfg.a) * rfg.rng.Float64();
                rfg.i += 1;
                return x, true;
        } else {
                return 0.0, false;
        }
}
/*** endif */
/*** if label == "A somewhat generic float -> float minimizer" */
type FloatGenerator interface {
        next() (float64, bool)
}

func minimize (f func (float64) float64, rfg FloatGenerator) (float64, float64, bool) {
        var min_x float64
        var min_y float64
        i := 0
        for {
                x, some := rfg.next()
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
/*** if label == "Apply a somewhat generic float -> float minimizer" */
func main() {
        f := func (x float64) float64 {
                return x * (x - 1.0) * (x - 2.0)
        }
        rfg := mk_random_float_generator(0.0, 2.0, 10000)
        x, y, some := minimize(f, rfg)
        if some {
                fmt.Printf("%f %f\n", x, y);
        } else {
                fmt.Printf("\n");
        }
}
/*** endif */
/*** if label == "Define a trivial generic type and a function" */
// does not work on Jupyter (use command line)
type triv [T any] struct {
        x T
}
func triv_val [T any] (t triv[T]) T {
        return t.x
}
/*** endif */
