struct Triv<T> {
    x : T
}

fn triv_val<T>(t : Triv::<T>) -> T {
    t.x
}

fn main() {
    let s = Triv::<i64>{x : 3};
    let x = triv_val(s);
    let t = Triv::<&str>{x : "hello"};
    let y = triv_val(t);
    println!("{}", x);
    println!("{}", y)
}
