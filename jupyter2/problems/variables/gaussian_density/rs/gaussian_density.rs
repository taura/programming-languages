/** begin my answer */

/** end my answer */

fn main() {
    assert!((gaussian_density(0.0, 1.0, 0.0) - 0.398942).abs() < 1.0e-5);
    assert!((gaussian_density(0.0, 2.0, 1.0) - 0.176033).abs() < 1.0e-5);
    assert!((gaussian_density(1.0, 3.0, 5.0) - 0.054670).abs() < 1.0e-5);
    println!("OK")
}
