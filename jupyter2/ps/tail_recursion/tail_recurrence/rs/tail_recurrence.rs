/** begin my answer */

/** begin hidden */
fn affine_recurrence_simple_tail_rec(a: f64, b: f64, m: i64, xm: f64, n: i64) -> f64 {
    if m == n {
        xm
    } else {
	let xm_1 = a * xm + b;
	affine_recurrence_simple_tail_rec(a, b, m + 1, xm_1, n)
    }
}
fn affine_recurrence_simple_tail(a: f64, b: f64, c: f64, n: i64) -> f64 {
    affine_recurrence_simple_tail_rec(a, b, 0, c, n)
}

fn affine_recurrence_fast_tail_rec(a: f64, b: f64, m: i64, xm: f64, n: i64) -> f64 {
    if m == n {
        xm
    } else if (n - m) % 2 == 0 {
        affine_recurrence_fast_tail_rec(a * a, a * b + b, m, xm, (m + n) / 2)
    } else {
	let xm_1 = a * xm + b;
	affine_recurrence_fast_tail_rec(a, b, m + 1, xm_1, n)
    }
}

fn affine_recurrence_fast_tail(a: f64, b: f64, c: f64, n: i64) -> f64 {
    affine_recurrence_fast_tail_rec(a, b, 0, c, n)
}

/** end hidden */
/** end my answer */

fn main() {
    assert!((affine_recurrence_fast_tail(0.9999, 1.0, 2.0, 100000)  - 9999.5463184).abs() < 1.0e-6);
    assert!((affine_recurrence_simple_tail(0.9999, 1.0, 2.0, 100000)  - 9999.5463184).abs() < 1.0e-6);
    assert!((affine_recurrence_fast_tail(0.9999, 1.0, 2.0, 1000000) - 10000.0).abs() < 1.0e-6);
    assert!((affine_recurrence_simple_tail(0.9999, 1.0, 2.0, 1000000) - 10000.0).abs() < 1.0e-6);
    println!("OK");
}
