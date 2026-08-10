struct S {
    x : i32
}

fn foo() -> i32 {
    let d = S{x: 42}; // allocate S
    let c: &S; // a reference to S
    { // an inner block
	let b: &S; // another reference
	let a = S{x: 42}; // allocate S
	// OK (both a and b live only until the end of the inner block)
	b = &a;
	c = b; // dangerous (c outlives a)
    } // a dies here, making c a dangling pointer
    c.x // NG (deref a dangling pointer)
}

fn main() {
    let x = foo();
    println!("{}", x);
}

