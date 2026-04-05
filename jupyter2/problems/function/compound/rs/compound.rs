/** begin my answer */

/** end my answer */

fn main() {
    assert!((compound(100.0, 0.1, 2.0) - 121.0).abs() < 1e-5);
    assert!((compound(100.0, 0.2, 5.0) - 248.832).abs() < 1e-5);
    assert!((compound(100.0, 0.3, 10.0) - 1378.584918).abs() < 1e-5);
    println!("OK")
}
