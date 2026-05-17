/** begin my answer */

/** begin hidden */
fn f<T>(x : T) -> T {
    x
}

fn g<T>(x : T) -> Vec<T> {
    vec![x]
}

fn h<T>(a : &[T]) -> Option<&T> {
    if a.len() == 0 {
	None
    } else {
	Some(&a[0])
    }
}

struct Cell<T> {
    x : T
}

fn get<T>(c : &Cell<T>) -> &T {
    return &c.x
}

fn put<T>(c : &mut Cell<T>, y : T) {
    c.x = y
}
/** end hidden */
/** end my answer */

fn main() {
    assert!(f(1) == 1);
    assert!(f("hello") == "hello");
    assert!(g(2) == [2]);
    assert!(g("world") == ["world"]);
    let mut c0 = Cell{x: 0};
    assert!(get(&c0) == &0);
    put(&mut c0, 42);
    let mut c1 = Cell{x: "mimura"};
    assert!(get(&c1) == &"mimura");
    put(&mut c1, "ohtake");
    assert!(get(&c1) == &"ohtake");
    assert!(h::<i64>(&vec![]) == None);
    assert!(h(&vec![3]) == Some(&3));
    assert!(h(&vec!["bye"]) == Some(&"bye"));
    println!("OK")
}
