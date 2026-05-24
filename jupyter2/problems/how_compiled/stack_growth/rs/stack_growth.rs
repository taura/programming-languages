#[no_mangle]
fn sum_array_rec(a : &[f64], n : usize) -> f64 {
    if n == 0 {
	0.0
    } else {
	sum_array_rec(a, n - 1) + a[n]
    }
}
