
pub struct Point {
    x : f64,
    y : f64
}
#[no_mangle]
pub fn get_point_y(p : Point) -> f64 {
    p.y
}
#[no_mangle]
pub fn get_pointp_y(p : &Point) -> f64 {
    return p.y;
}
#[no_mangle]
pub fn get_pointb_y(p : Box::<Point>) -> f64 {
    return p.y;
}
