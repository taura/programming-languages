/** begin my answer */

/** begin hidden */
fn point_line_distance(x0: f64, y0: f64, x1: f64, y1: f64, p: f64, q: f64) -> f64 {
    let dx = x1 - x0;
    let dy = y1 - y0;
    let a = dy;
    let b = -dx;
    let num = (a * (p - x0) + b * (q - y0)).abs();
    let den = (a * a + b * b).sqrt();
    num / den
}
/** end hidden */
/** end my answer */

fn main() {
    assert!((point_line_distance(-3.0, 1.0, 1.0, -2.0, 4.0, -3.0) - 1.0).abs() < 1.0e-5);
    assert!((point_line_distance( 2.0, 2.0, 4.0,  0.0, 1.0,  0.0) - 2.12132).abs() < 1.0e-5);
    assert!((point_line_distance( 1.0, 1.0, 4.0,  3.0, 3.0, -2.0) - 3.60555).abs() < 1.0e-5);
    println!("OK")
}
