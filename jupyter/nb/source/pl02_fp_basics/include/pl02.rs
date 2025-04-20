/*** if label == "A simple recurrence" */
fn a(n : i64) -> f64 {
    if n == 0 {
        1.0
    } else {
        0.9 * a(n - 1) + 2.0
    }
}
/*** endif */
/*** if label == "A simple recurrence test" */
fn float64_close(x : f64, y : f64, eps : f64) {
    if (x - y).abs() > eps {
        println!("NG")
    } else {
        println!("OK")
    }
}
/*** if 0 */
fn a_test() {
/*** endif */
    float64_close(a(0),   1.0,        1.0e-6);
    float64_close(a(10),  13.3751096, 1.0e-6);
    float64_close(a(100), 19.9994953, 1.0e-6);
    float64_close(a(300), 20.0,       1.0e-6);
/*** if 0 */
}
/*** endif */
/*** endif */
/*** if label == "The smallest divisor" */
fn smallest_divisor_geq(n : i64, x : i64) -> i64 {
    if n % x == 0 {
        x
    } else if n < x * x {
        n
    } else {
        smallest_divisor_geq(n, x + 1)
    }
}
/*** endif */
/*** if label == "The smallest divisor test"*/
fn int64_eq(x : i64, y : i64) {
    if x == y {
        println!("OK")
    } else {
        println!("NG")
    }
}
/*** if 0 */
fn smallest_divisor_geq_test() {
/*** endif */
    int64_eq(smallest_divisor_geq(2,          2), 2);
    int64_eq(smallest_divisor_geq(3,          2), 3);
    int64_eq(smallest_divisor_geq(13 * 17,    2), 13);
    int64_eq(smallest_divisor_geq(6700417, 2), 6700417)
/*** if 0 */
}
/*** endif */
/*** endif */
/*** if label == "Factorize" */
fn factorize(n : i64) -> Vec<i64> {
    if n == 1 {
        vec![]
    } else {
        let x = smallest_divisor_geq(n, 2);
        let a = factorize(n / x);
        [vec![x], a].concat()
    }
}
/*** endif */
/*** if label == "Factorize test" */
fn int64_list_eq(a : Vec<i64>, b : Vec<i64>) {
    if a == b {
        println!("OK")
    } else {
        println!("NG")
    }
}
/*** if 0 */
fn factorize_test() {
/*** endif */
    int64_list_eq(factorize(64), vec![2, 2, 2, 2, 2, 2]);
    int64_list_eq(factorize(105), vec![3, 5, 7])
/*** if 0 */
}
/*** endif */
/*** endif */
/*** if label == "Subset sum" */
fn subset_sum(a : &[i64], v : i64) -> Option<Vec<i64>> {
    if v == 0 {
        Some(vec![0; a.len()])
    } else if v < 0 || a.len() == 0 {
        None
    } else {
        match subset_sum(&a[1..], v - a[0]) {
            Some(k1) => Some([vec![1], k1].concat()),
            None => match subset_sum(&a[1..], v) {
                Some(k0) => Some([vec![0], k0].concat()),
                None => None
            }
        }
    }
}
/*** endif */
/*** if label == "Subset sum test" */
fn int64_list_opt_eq(a : Option<Vec<i64>>, b : Option<Vec<i64>>) {
    match a {
        None => match b {
            None => println!("OK"),
            Some(_) => println!("NG")
        },
        Some(x) => match b {
            None => println!("NG"),
            Some(y) => int64_list_eq(x, y)
        }
    }
}
/*** if 0 */
fn subset_sum_test() {
/*** endif */
    int64_list_opt_eq(subset_sum(&vec![1,2,3,4,5], 8), Some(vec![1, 1, 0, 0, 1]));
    int64_list_opt_eq(subset_sum(&vec![33, 28, 56, 35, 19, 46, 25, 58, 17, 49, 33, 39, 37, 33, 24, 52], 233),
                      Some(vec![1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0]));
    int64_list_opt_eq(subset_sum(&vec![30, 37, 46, 41, 14, 46, 44, 40, 46, 30, 46, 28, 33, 31, 56], 171),
                      Some(vec![1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]));
    int64_list_opt_eq(subset_sum(&vec![47, 39, 15, 27, 52, 31, 39, 54, 20, 26, 38, 19, 35, 28], 440), None);
    int64_list_opt_eq(subset_sum(&vec![16, 24, 13, 20, 24, 13, 11, 31, 29, 44], 222), None)
/*** if 0 */
}
/*** endif */
/*** endif */
/*** if 0 */
fn main() {
    println!("a");
    a_test();
    println!("smallest_divisor_geq");
    smallest_divisor_geq_test();
    println!("factorize");
    factorize_test();
    println!("subset_sum");
    subset_sum_test()
}
/*** endif */
