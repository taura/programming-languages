#[no_mangle]
fn call_tanh(x : f64) -> f64 {
    (x + 1.0).tanh() + x
}
