/** begin my answer */

/** end my answer */

fn main() {
    let pi = std::f64::consts::PI;
    assert!((gaussian_integral(1.0, 1000) - 1.493648).abs() < 1.0e-6);
    assert!((gaussian_integral(2.0, 2000) - 1.764163).abs() < 1.0e-6);
    assert!((gaussian_integral(10.0, 10000) - pi.sqrt()).abs() < 1.0e-6);
    println!("OK");
}
