/** begin my answer */

/** end my answer */

fn main() {
    assert!((continued_fraction(2.0, 100) - 0.4142136).abs() < 1.0e-6);
    assert!((continued_fraction(3.0, 100) - 0.3027756).abs() < 1.0e-6);
    assert!((continued_fraction(4.0, 100) - 0.2360680).abs() < 1.0e-6);
    println!("OK");
}
