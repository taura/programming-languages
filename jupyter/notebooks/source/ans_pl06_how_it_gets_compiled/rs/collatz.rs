
#[no_mangle]
pub fn collatz(n : i64) -> i64 {
    if n % 2 == 0 {
        n / 2
    } else {
        3 * n + 1
    }
}
