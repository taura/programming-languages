/** begin my answer */

/** end my answer */

fn main() {
    assert!((point_line_distance(-3.0, 1.0, 1.0, -2.0, 4.0, -3.0) - 1.0).abs() < 1.0e-5);
    assert!((point_line_distance( 2.0, 2.0, 4.0,  0.0, 1.0,  0.0) - 2.12132).abs() < 1.0e-5);
    assert!((point_line_distance( 1.0, 1.0, 4.0,  3.0, 3.0, -2.0) - 3.60555).abs() < 1.0e-5);
    println!("OK")
}
