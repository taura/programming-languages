#[no_mangle]
fn gcd1(a : i64, b : i64) -> i64 {
    if b == 0 {
	a
    } else {
	a % b
    }
}
