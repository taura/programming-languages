fn affine_recurrence_iter(a: f64, b: f64, c: f64, n: i64) -> f64 {
    let mut x = c;
    for _i in 0..n {
	x = a * x + b
    }
    x
}
/** begin my answer */

/** end my answer */

fn main() {
    assert!((affine_recurrence_simple(0.9,  1.0, 2.0, 100)     - 9.9997875).abs() < 1.0e-6);
    assert!((affine_recurrence_simple(0.99, 1.0, 2.0, 1000)    - 99.9957692).abs() < 1.0e-6);
    assert!((affine_recurrence_fast(0.99,   1.0, 2.0, 1000)    - 99.9957692).abs() < 1.0e-6);
    assert!((affine_recurrence_fast(0.99,   1.0, 2.0, 10000)   - 100.0).abs() < 1.0e-6);
    assert!((affine_recurrence_fast(0.999,  1.0, 2.0, 10000)   - 999.9549170).abs() < 1.0e-6);
    assert!((affine_recurrence_fast(0.999,  1.0, 2.0, 100000)  - 1000.0).abs() < 1.0e-6);
    assert!((affine_recurrence_fast(0.9999, 1.0, 2.0, 100000)  - 9999.5463184).abs() < 1.0e-6);
    assert!((affine_recurrence_iter(0.9999, 1.0, 2.0, 100000)  - 9999.5463184).abs() < 1.0e-6);
    assert!((affine_recurrence_fast(0.9999, 1.0, 2.0, 1000000) - 10000.0).abs() < 1.0e-6);
    assert!((affine_recurrence_iter(0.9999, 1.0, 2.0, 1000000) - 10000.0).abs() < 1.0e-6);
    println!("OK");
}
