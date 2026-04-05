/** begin my answer */

/** begin hidden */
fn height(h0: f64, v0: f64, t: f64) -> f64 {
    h0 + v0*t - 0.5*9.8*t*t
}
/** end hidden */
/** end my answer */

fn main() {
    assert!((height(10.0,  1.0, 1.0) -   6.1).abs() < 1e-5);
    assert!((height(20.0,  0.0, 2.0) -   0.4).abs() < 1e-5);
    assert!((height(30.0, -1.0, 3.0) - -17.1).abs() < 1e-5);
    println!("OK");
}
