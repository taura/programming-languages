#![allow(unused_variables)]
#![allow(unused_mut)]

/*
(1) need to add lifetime parameters to reference types
(2) struct must take lifetime parameters that appear in fields
 */

struct A { b : &B }
struct B { c : &C }
struct C { x : i32 }

fn main() {
    let c = C{x : 123};
    let b = B{c : &c};
    let mut a = A{b : &b};
    {
        let b_ = B{c : &c};
        a.b = &b_;
    }
    a.b.c.x;                    // OK?
}
