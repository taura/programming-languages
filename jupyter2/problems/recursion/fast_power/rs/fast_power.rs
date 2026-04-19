fn power_iter(a: f64, n: i64) -> f64 {
    let mut p = 1.0;
    for _i in 1..n+1 {
        p *= a
    }
    p
}
/** begin my answer */

/** end my answer */

fn main() {
    assert!((power_slow(1.0 + 1.0/10.0,        10).abs()       - 2.59374246) < 1.0e-7);
    assert!((power_fast(1.0 + 1.0/10.0,        10).abs()       - 2.59374246) < 1.0e-7);
    assert!((power_slow(1.0 + 1.0/100.0,       100).abs()      - 2.70481383) < 1.0e-7);
    assert!((power_fast(1.0 + 1.0/100.0,       100).abs()      - 2.70481383) < 1.0e-7);
    assert!((power_fast(1.0 + 1.0/1000000.0,   1000000).abs()  - 2.71828047) < 1.0e-7);
    assert!((power_iter(1.0 + 1.0/1000000.0,   1000000).abs()  - 2.71828047) < 1.0e-7);
    assert!((power_fast(1.0 + 1.0/10000000.0,  10000000).abs() - 2.71828169) < 1.0e-7);
    assert!((power_iter(1.0 + 1.0/10000000.0,  10000000).abs() - 2.71828169) < 1.0e-7);
    assert!((power_fast(1.0 + 1.0/100000000.0, 100000000).abs() - 2.71828179) < 1.0e-7);
    assert!((power_iter(1.0 + 1.0/100000000.0, 100000000).abs() - 2.71828180) < 1.0e-7);
    println!("OK");
}
