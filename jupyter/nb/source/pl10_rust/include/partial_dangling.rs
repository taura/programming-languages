#![allow(dead_code)]
#![allow(unused_mut)]
#![allow(unused_must_use)]
#![allow(unused_variables)]
  
struct S<'a,'b> {
    a : &'a i32,
    b : &'b i32
}

fn main() {
    let a = 123;
    let mut s = S{a: &a, b: &a};
    {
        let b = 456;
        s.b = &b;
    }
    *s.a; // (*)
}
