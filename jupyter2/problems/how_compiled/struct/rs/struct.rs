#![allow(dead_code)]

struct Point {
    x : f64,
    y : f64
}

#[no_mangle]
fn get_point_y(p : Point) -> f64 {
    p.y
}
