#[no_mangle]
fn sum_array_tail(a : &[f64], i : usize, n : usize, s : f64) -> f64 {
    if i == n {
	s
    } else {
	sum_array_tail(a, i + 1, n, s + a[i])
    }
}
