/** begin my answer */

/** begin hidden */
fn continued_fraction_tail_rec(a: f64, m: i64, xm: f64, n: i64) -> f64 {
    if m == n {
        xm
    } else {
	let xm_1 = 1.0 / (a + xm);
        continued_fraction_tail_rec(a, m + 1, xm_1, n)
    }
}

fn continued_fraction_tail(a: f64, n: i64) -> f64 {
    continued_fraction_tail_rec(a, 0, 1.0, n)
}
/** end hidden */
/** end my answer */

fn main() {
    assert!((continued_fraction_tail(2.0, 100) - 0.4142136).abs() < 1.0e-6);
    assert!((continued_fraction_tail(3.0, 100) - 0.3027756).abs() < 1.0e-6);
    assert!((continued_fraction_tail(4.0, 100) - 0.2360680).abs() < 1.0e-6);
    println!("OK");
}
