
#[no_mangle]
pub fn call_tanh(x : f64) -> f64 {
    (x + 1.0).tanh() + x
}
