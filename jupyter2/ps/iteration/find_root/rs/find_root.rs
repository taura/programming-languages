/** begin my answer */

/** begin hidden */
fn find_root(a: f64, b: f64, eps: f64) -> f64 {
    let f = |x: f64| x*x*x - x - 2.0;
    let mut l = a;
    let mut r = b;
    while (r - l).abs() > eps {
        let c = 0.5 * (l + r);
	if f(l) * f(c) < 0.0 {
            r = c;
        } else {
            l = c;
        }
    }
    0.5 * (l + r)
}
/** end hidden */
/** end my answer */

fn main() {
    assert!((find_root(0.0, 2.0, 1.0e-20) - 1.5213797).abs() < 1.0e-6);
    println!("OK");
}
