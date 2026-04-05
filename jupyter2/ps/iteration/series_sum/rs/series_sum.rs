/** begin my answer */

/** begin hidden */
fn series_sum(n: i64) -> f64 {
    let mut sum = 0.0;
    for k in 1..=n {
        let x = k as f64;
        sum += 1.0 / (x * x);
    }
    sum
}
/** end hidden */
/** end my answer */

fn main() {
    let pi = std::f64::consts::PI;
    let a = pi * pi / 6.0;
    assert!((series_sum(10) - 1.549768).abs() < 1.0e-5);
    assert!((series_sum(100000) - a).abs() < 1.0e-5);
    assert!((series_sum(1000000) - a).abs() < 1.0e-6);
    assert!((series_sum(20000000) - a).abs() < 1.0e-6);
    println!("OK");
}
