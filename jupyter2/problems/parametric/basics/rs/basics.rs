/** begin my answer */

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
