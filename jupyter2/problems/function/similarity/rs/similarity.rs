/** begin my answer */

/** end my answer */

fn main() {
    assert!((similarity(1.0, 2.0,  2.0,  4.0) - 1.0).abs() < 1e-5);
    assert!((similarity(1.0, 2.0,  3.0,  5.0) - 0.997054).abs() < 1e-5);
    assert!((similarity(2.0, 3.0,  3.0, -2.0) - 0.0).abs() < 1e-5);
    assert!((similarity(3.0, 4.0, -3.0, -1.0) - -0.82219).abs() < 1e-5);
    println!("OK")
}
