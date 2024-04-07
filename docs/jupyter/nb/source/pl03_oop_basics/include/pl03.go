/*** if 0 */
package main
/*** endif */
/*** if label == "Define a method that computes the area of rect/ellipse" */
import "math"
/*** endif */
/*** if label == "Define data structure representing a rectangle and an ellipse" */
type rect struct {
        x, y, width, height int
}

type ellipse struct {
        x, y, rx, ry int
}
/*** endif */
/*** if label == "Define a method that computes the area of rect/ellipse" */
func (r rect) area() float64 {
        return float64(r.width * r.height)
}

func (e ellipse) area() float64 {
        return float64(e.rx * e.ry) * math.Pi
}
/*** endif */
/*** if label == "Create an array/a list/a vector/a slice" */
type shape interface {
        area() float64
}

var shapes []shape = []shape{
        rect{0, 0, 100, 100},
        ellipse{0, 0, 100, 50},
}
/*** endif */
/*** if label == "Scan an array of shapes" */
func sum_area(shapes []shape) float64 {
        sa := 0.0
        for _, s := range shapes {
                sa += s.area()
        }
        return sa
}
/*** endif */
/*** if 0 */
func main() {
/*** endif */
/*** if label == "Scan an array of shapes" */
sum_area(shapes)
/*** endif */
/*** if 0 */
}
/*** endif */
