/** begin my answer */

/** end my answer */

fn main() {
    assert!((clamp(-3.0, 0.0, 10.0) -  0.0).abs() < 1.0e-5);
    assert!((clamp( 4.0, 0.0, 10.0) -  4.0).abs() < 1.0e-5);
    assert!((clamp(15.0, 0.0, 10.0) - 10.0).abs() < 1.0e-5);
    println!("OK")
}
