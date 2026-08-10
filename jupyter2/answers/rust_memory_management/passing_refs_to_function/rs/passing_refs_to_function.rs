struct S {
    x : i32
}

fn foo(ra: &S, rb: &S, rc: &S) -> &S {
    rb
}

fn main() {
    let r : &S;
    let a = S { x: 42 };
    {
	let b = S { x: 43 };
	{
	    let c = S { x: 44 };
	    {
		r = foo(&a, &b, &c);
	    }
	}
    }
    println!("{}", r.x);
}

