struct S {
    x : i32
}

fn f(s: S) {
    println!("{}", s.x);
}

fn main() {
    let a = S { x: 42 };
    f(a);
    println!("{}", a.x);
}

