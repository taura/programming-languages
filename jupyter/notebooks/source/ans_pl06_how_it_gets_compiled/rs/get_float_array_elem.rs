
#[no_mangle]
pub fn get_float_array_elem_const(a : &[f64; 10]) -> f64 {
    a[2]
}
#[no_mangle]
pub fn get_float_array_elem_i(a : &[f64; 10], i : usize) -> f64 {
    a[i]
}
