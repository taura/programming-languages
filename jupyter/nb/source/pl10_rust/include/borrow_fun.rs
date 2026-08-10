#![allow(unused_variables)]
#![allow(unused_assignments)]
#![allow(dead_code)]
#![allow(unused_must_use)]

/*
(1) need to add lifetime parameters to function parameter types
(2) the function must take those lifetime parameters
 */
fn foo(ra : &i32, rb : &i32, rc : &i32) -> &i32 {
    ra
}

fn main() {
    let r : &i32;
    let a = 123;
    {
        let b = 456;
        {
            let c = 789;
            r = foo(&a, &b, &c);
        }
    }
    *r;
}
