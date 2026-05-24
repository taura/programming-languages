#![allow(dead_code)]

struct Point {
    x : f64,
    y : f64
}

#[no_mangle]
fn mk_point(x : f64, y : f64) -> Point {
    Point { x: x + 1.0, y: y + 2.0 }
}
