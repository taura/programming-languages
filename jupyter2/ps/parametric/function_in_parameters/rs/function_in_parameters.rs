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

fn app1<T>(g : fn(f64) -> T) -> T {
    g(1.0)
}

fn app<S, T>(f : fn(S) -> T, x : S) -> T {
    f(x)
}
/** end hidden */
/** end my answer */

fn main() {
    assert!(app1(f) == 1.0);
    assert!(app1(g) == [1.0]);
    assert!(app(f, 4) == 4);
    assert!(app(h, &vec!["bye"]) == Some(&"bye"));
    println!("OK")
}
