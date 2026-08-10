#![allow(unused_variables)]

struct S {
    x : i64,
    y : i64,
}

fn f(s : S) {
    
}

fn main() {
    let a = S{x : 123, y : 456};
    a.x;
    a.y;
    f(a);
    a.x;
}
