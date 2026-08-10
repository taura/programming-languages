
package pl06
type Point struct {
    x float64
    y float64
}
func Get_point_y(p Point) float64 {
    return p.y
}
func Get_pointp_y(p * Point) float64 {
    return p.y
}
