/** begin my answer */

/** begin hidden */
fn f(a : f64, b : f64, c : f64) -> f64 {
    a * a + b * b - c * c
}
/** end hidden */
/** end my answer */

fn main() {
    assert!((f(1.0, 2.0, 3.0) - -4.0).abs() < 1.0e-5);
    assert!((f(3.0, 4.0, 5.0) - -0.0).abs() < 1.0e-5);
    assert!((f(5.0, 6.0, 7.0) - 12.0).abs() < 1.0e-5);
    println!("OK")
}
