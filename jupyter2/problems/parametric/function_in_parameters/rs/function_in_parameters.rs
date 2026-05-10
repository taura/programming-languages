/** begin my answer */

/** end my answer */

fn main() {
    assert!(app1(f) == 1.0);
    assert!(app1(g) == [1.0]);
    assert!(app(f, 4) == 4);
    assert!(app(h, &vec!["bye"]) == Some(&"bye"));
    println!("OK")
}
