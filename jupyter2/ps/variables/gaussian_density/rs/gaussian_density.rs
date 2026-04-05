/** begin my answer */

/** begin hidden */
fn gaussian_density(mu: f64, sigma: f64, x: f64) -> f64 {
    let z = (x - mu) / sigma;
    let z2 = z * z;
    let norm = 1.0 / ((2.0 * std::f64::consts::PI).sqrt() * sigma);
    norm * (-0.5 * z2).exp()
}
/** end hidden */
/** end my answer */

fn main() {
    assert!((gaussian_density(0.0, 1.0, 0.0) - 0.398942).abs() < 1.0e-5);
    assert!((gaussian_density(0.0, 2.0, 1.0) - 0.176033).abs() < 1.0e-5);
    assert!((gaussian_density(1.0, 3.0, 5.0) - 0.054670).abs() < 1.0e-5);
    println!("OK")
}
