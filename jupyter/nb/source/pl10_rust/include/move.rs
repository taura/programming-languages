#![allow(unused_variables)]

struct S {
    x : i64,
    y : i64,
}

fn main() {
    let a = S{x : 123, y : 456};
    a.x;
    a.y;
    let b = a;
    a.x;
    b.x;
}
