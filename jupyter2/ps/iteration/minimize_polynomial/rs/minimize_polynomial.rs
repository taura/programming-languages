/** begin my answer */

/** begin hidden */
fn min_value(a: f64, b: f64, n: i64) -> f64 {
    let f = |x: f64| x*x*x*x - 3.0*x*x*x + 2.0*x*x + x + 1.0;
    let mut best = f(a);
    for i in 1..=n {
        let x = a + (b - a) * (i as f64) / (n as f64);
        let v = f(x);
        if v < best {
            best = v;
        }
    }
    best
}
/** end hidden */
/** end my answer */

fn main() {
    assert!((min_value(-1.0, 1.0, 1000) - 0.903266).abs() < 1.0e-6);
    assert!((min_value( 1.0, 2.0, 1000) - 1.928766).abs() < 1.0e-6);
    println!("OK");
}
