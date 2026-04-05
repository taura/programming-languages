/** begin my answer */

/** end my answer */

fn main() {
    assert!((triangle_area(0.0,0.0,1.0,0.0,0.0,1.0) - 0.5).abs() < 1.0e-5);
    assert!((triangle_area(0.0,0.0,2.0,0.0,0.0,2.0) - 2.0).abs() < 1.0e-5);
    assert!((triangle_area(1.0,1.0,4.0,1.0,1.0,5.0) - 6.0).abs() < 1.0e-5);
    println!("OK")
}
