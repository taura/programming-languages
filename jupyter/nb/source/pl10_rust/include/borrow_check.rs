#![allow(unused_variables)]
#![allow(unused_assignments)]
#![allow(dead_code)]

struct S {
    x : i64,
    y : i64,
}

fn main() {
    let c : &S;                 // gamma
    {
        let b : &S;             // beta
        let a = S{x : 123, y : 456}; // alpha = inside this block (*)
        b = &a;                      // beta subset alpha
        c = b;                       // gamma subset beta
    } // ... (*)
    c.x;                        // this point in gamma? -> no -> invalid
}



