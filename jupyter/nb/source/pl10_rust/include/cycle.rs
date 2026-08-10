#![allow(unused_variables)]
#![allow(unused_mut)]

struct S {
    p : Option<Box<S>>
}

fn main() {
    // an attemp to make a cyclic data structure
    // a <-> b
    let mut a = S{p : None};
    let mut b = S{p : None};
    a.p = Some(Box::new(b));
    b.p = Some(Box::new(a));
}
