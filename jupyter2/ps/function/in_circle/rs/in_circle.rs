/** begin my answer */

/** begin hidden */
fn in_circle(x: f64, y: f64, r: f64) -> bool {
    x*x + y*y <= r*r
}
/** end hidden */
/** end my answer */

fn main() {
    assert!( in_circle(1.0, 1.0, 2.0));
    assert!( in_circle(3.0, 4.0, 6.0));
    assert!(!in_circle(3.0, 0.0, 2.0));
    println!("OK")
}
