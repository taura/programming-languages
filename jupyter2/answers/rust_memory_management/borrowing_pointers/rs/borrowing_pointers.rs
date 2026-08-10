struct S {
    x : i32
}

fn main() {
    let a = S { x: 42 };
    let b = &a;
    println!("{}", a.x + b.x);
}

