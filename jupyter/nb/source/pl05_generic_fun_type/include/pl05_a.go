/*** if 0 */ 
package main
/*** endif */ 
/*** if label == "A domain class for a floating point number"  */
import "math/rand"
/*** endif */
/*** if label == "Apply float -> float minimizer" */
import "fmt"
/*** endif */
/*** if label == "A function that takes a function"  */
func f(g func (float64) float64) float64 { return g(1.0); }
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
/*** if label == "A minimizer for float -> float functions" */
func minimize (f func (float64) float64, rfg * RandomFloatGenerator) (float64, float64, bool) {
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
/*** if label == "Apply float -> float minimizer" */
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
