/** begin my answer */

/** end my answer */

fn main() {
    assert!((min_value(-1.0, 1.0, 1000) - 0.903266).abs() < 1.0e-6);
    assert!((min_value( 1.0, 2.0, 1000) - 1.928766).abs() < 1.0e-6);
    println!("OK");
}
