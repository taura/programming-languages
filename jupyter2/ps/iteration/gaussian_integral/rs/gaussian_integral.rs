/** begin my answer */

/** begin hidden */
fn gaussian_integral(a: f64, n: i64) -> f64 {
    let dx = 2.0 * a / (n as f64);
    let mut sum = 0.0;
    for i in 0..n {
        let x = -a + (i as f64) * dx;
        sum += (-x * x).exp() * dx;
    }
    sum
}
/** end hidden */
/** end my answer */

fn main() {
    let pi = std::f64::consts::PI;
    assert!((gaussian_integral(1.0, 1000) - 1.493648).abs() < 1.0e-6);
    assert!((gaussian_integral(2.0, 2000) - 1.764163).abs() < 1.0e-6);
    assert!((gaussian_integral(10.0, 10000) - pi.sqrt()).abs() < 1.0e-6);
    println!("OK");
}
