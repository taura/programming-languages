/** begin my answer */

fn gcd(a: i64, b: i64) -> i64 {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}
/** end my answer */

fn main() {
    assert!(gcd(1499276220,   463728183) == 6873);
    assert!(gcd(256381708674, 48941846742) == 35094);
    assert!(gcd(8619803849,   3861314192) == 11437);
    println!("OK");
}
