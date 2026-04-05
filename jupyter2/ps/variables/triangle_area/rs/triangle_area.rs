/** begin my answer */

/** begin hidden */
fn triangle_area(x1: f64, y1: f64,
		 x2: f64, y2: f64,
		 x3: f64, y3: f64) -> f64 {
    let dx21 = x2 - x1;
    let dy21 = y2 - y1;
    let dx31 = x3 - x1;
    let dy31 = y3 - y1;
    0.5 * (dx21 * dy31 - dx31 * dy21).abs()
}
/** end hidden */
/** end my answer */

fn main() {
    assert!((triangle_area(0.0,0.0,1.0,0.0,0.0,1.0) - 0.5).abs() < 1.0e-5);
    assert!((triangle_area(0.0,0.0,2.0,0.0,0.0,2.0) - 2.0).abs() < 1.0e-5);
    assert!((triangle_area(1.0,1.0,4.0,1.0,1.0,5.0) - 6.0).abs() < 1.0e-5);
    println!("OK")
}
