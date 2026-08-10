#[no_mangle]
fn sum_array_loop(a : &[f64], n : usize) -> f64 {
    let mut s = 0.0;
    for i in 0..n {
	s += a[i];
    }
    s
}
