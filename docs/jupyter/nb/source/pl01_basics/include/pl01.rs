/*** if label == "A function" */
fn f(x: i32) -> i32 {
        return x + 1
}
/*** endif */
/*** if label == "Apply a function" */
f(3)
/*** endif */
/*** if label == "A recursive function"  */
fn fib(n: i32) -> i32 {
    if n < 2 {
        1
    } else {
        fib(n - 1) + fib(n - 2)
    }
}
/*** endif */
/*** if label == "A variable"  */
fn fib2(n: i32) -> i32 {
    if n < 2 {
        1
    } else {
        let x = fib2(n - 1);
        let y = fib2(n - 2);
        x + y
    }
}
/*** endif */
/*** if label == "A data type"  */
struct Person {
    name: String,
    date_of_birth: String
}
/*** endif */
/*** if label == "Person name"  */
fn person_name(p : Person) -> String {
        return p.name
}
/*** endif */
/*** if 0 */
#[allow(dead_code)]
fn mk_person() -> String {
/*** endif */
/*** if label == "Person name"  */
person_name(Person{name: String::from("Masakazu Mimura"),
                   date_of_birth: String::from("1967/6/8")})
/*** endif */
/*** if 0 */
}
/*** endif */
/*** if 0 */
#[allow(dead_code,unused_variables)]
fn use_them() {
    let a = f(3);
    let b = fib(10);
    let c = fib2(10);
    let d = Person{name: String::from("Masakazu Mimura"),
                   date_of_birth: String::from("1967/06/08")};
    let e = d.name;
    let f = d.date_of_birth;
}
/*** endif */
/*** if label == "bintree"  */
enum Bintree {
    Empty,
    Node { left: Box<Bintree>, right: Box<Bintree> }
}
/*** endif */
/*** if label == "mk_tree"  */
fn mk_tree(n: i32) -> Bintree {
    if n == 0 {
        Bintree::Empty
    } else {
        let rc = (n - 1) / 2;
        let lc = n - 1 - rc;
        Bintree::Node{left: Box::new(mk_tree(lc)),
                      right: Box::new(mk_tree(rc))}
    }
}
/*** endif */
/*** if label == "count_nodes"  */
fn count_nodes(t: Bintree) -> i32 {
    match t {
        Bintree::Empty => 0,
        Bintree::Node{left, right} =>
            1 + count_nodes(*left) + count_nodes(*right)
    }
}
/*** endif */
/*** if 0 */
fn main() {
/*** endif */
/*** if label == "1000 nodes"  */
count_nodes(mk_tree(1000))
/*** endif */
/*** if 0 */
        ;
}
/*** endif */
