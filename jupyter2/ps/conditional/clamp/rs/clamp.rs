/** begin my answer */

/** begin hidden */
fn clamp(x: f64, low: f64, high: f64) -> f64 {
    if x < low {
        low
    } else if x > high {
        high
    } else {
        x
    }
}
/** end hidden */
/** end my answer */

fn main() {
    assert!((clamp(-3.0, 0.0, 10.0) -  0.0).abs() < 1.0e-5);
    assert!((clamp( 4.0, 0.0, 10.0) -  4.0).abs() < 1.0e-5);
    assert!((clamp(15.0, 0.0, 10.0) - 10.0).abs() < 1.0e-5);
    println!("OK")
}
