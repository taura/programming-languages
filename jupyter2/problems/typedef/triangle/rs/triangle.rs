/** begin my answer */

/** end my answer */
fn check(x0 : f64, y0 : f64, x1 : f64, y1 : f64, x2 : f64, y2 : f64, a : f64) -> bool {
    let t = Triangle { a: Vec2 { x: x0, y: y0 }, b: Vec2 { x: x1, y: y1 }, c: Vec2 { x: x2, y: y2 } };
    (area_of_triangle(t) - a).abs() < 1e-6
}

fn main() {
    assert!(check(0.,  0.,  1.,  0.,  0.,  1.,  0.500));
    assert!(check(9.9, 0.3, 3.2, 5.1, 6.1, 0.2,  9.455));
    assert!(check(4.6, 6.4, 0.4, 0.3, 5.5, 9.1,  2.925));
    assert!(check(5.2, 5.5, 9.9, 0.0, 3.1, 4.0,  9.300));
    assert!(check(6.0, 1.2, 0.6, 5.5, 9.9, 3.2, 13.785));
    println!("OK")
}
