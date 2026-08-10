struct S {
    x : i32
}

struct T<'a> {
    s : &'a S
}

fn main() {
    let s0 = S { x: 42 };
    let t : T;
    {
	let s1 = S { x: 43 };
	t = T { s: &s0 };
    }
    println!("{}", t.s.x);
}

