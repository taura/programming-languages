trait Shape {
    fn area(&self) -> f64;
}

#[no_mangle]
fn call_area(s : &dyn Shape) -> f64 {
    s.area()
}

