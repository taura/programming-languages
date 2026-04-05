/** begin my answer */

/** begin hidden */
fn gcd(a: i64, b: i64) -> i64 {
    let mut x = a;
    let mut y = b;
    while y != 0 {
        let r = x % y;
        x = y;
        y = r;
    }
    x
}
/** end hidden */
/** end my answer */

fn main() {
    assert!(gcd(1499276220, 463728183) == 6873);
    assert!(gcd(256381708674, 48941846742) == 35094);
    assert!(gcd(8619803849, 3861314192) == 11437);
    println!("OK");
}
