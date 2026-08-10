#[no_mangle]
fn get_array_elem(a : &[f64], i : usize) -> f64 {
    a[i]
}
