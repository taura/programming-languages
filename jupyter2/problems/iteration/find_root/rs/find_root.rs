/** begin my answer */

/** end my answer */

fn main() {
    assert!((find_root(0.0, 2.0, 1.0e-20) - 1.5213797).abs() < 1.0e-6);
    println!("OK");
}
