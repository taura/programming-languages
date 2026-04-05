/** begin my answer */

/** begin hidden */
fn sigmoid(x: f64) -> f64 {
    1.0 / (1.0 + (-x).exp())
}
/** end hidden */
/** end my answer */

fn main() {
    assert!((sigmoid(-5.0) - 0.00669).abs() < 1e-5);
    assert!((sigmoid(-0.5) - 0.37754).abs() < 1e-5);
    assert!((sigmoid(0.0)  - 0.5).abs() < 1e-5);
    assert!((sigmoid(10.0) - 0.999954).abs() < 1e-5);
    println!("OK")
}
