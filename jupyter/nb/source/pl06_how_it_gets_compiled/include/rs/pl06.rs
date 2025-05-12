/*** if label == "add123" */
#[no_mangle]
pub fn add123(n : i64) -> i64 {
    n + 123
}
/*** endif */
/*** if label == "many_args" */
#[no_mangle]
pub fn many_args(a00 : i64, a01 : i64, a02 : i64, a03 : i64, a04 : i64, a05 : i64,
                 a06 : i64, a07 : i64, a08 : i64, a09 : i64, a10 : i64, a11 : i64) -> i64 {
    a00 + a01 + a02 + a03 + a04 + a05 + a06 + a07 + a08 + a09 + a10 + a11
}
/*** endif */
/*** if label == "add_floats" */
#[no_mangle]
pub fn add_floats(x : f64, y : f64) -> f64 {
    x + y
}
/*** endif */
/*** if label == "get_float_array_elem" */
#[no_mangle]
pub fn get_float_array_elem_const(a : &[f64; 10]) -> f64 {
    a[2]
}
#[no_mangle]
pub fn get_float_array_elem_i(a : &[f64; 10], i : usize) -> f64 {
    a[i]
}
/*** endif */
/*** if label == "get_struct_elem" */
pub struct Point {
    x : f64,
    y : f64
}
#[no_mangle]
pub fn get_point_y(p : Point) -> f64 {
    p.y
}
#[no_mangle]
pub fn get_pointp_y(p : &Point) -> f64 {
    return p.y;
}
#[no_mangle]
pub fn get_pointb_y(p : Box::<Point>) -> f64 {
    return p.y;
}
/*** endif */
/*** if label == "collatz" */
#[no_mangle]
pub fn collatz(n : i64) -> i64 {
    if n % 2 == 0 {
        n / 2
    } else {
        3 * n + 1
    }
}
/*** endif */
/*** if label == "regions" */
#[no_mangle]
pub fn regions(n : i64) -> i64 {
    if n == 0 {
        1
    } else {
        regions(n - 1) + n - 1
    }
}
/*** endif */
/*** if label == "sum_array_rec" */
pub fn sum_array_rec(a : &[f64], p : usize, q : usize) -> f64 {
    if q - p == 0 {
        0.0
    } else if q - p == 1 {
        a[p]
    } else {
        let r = (p + q) / 2;
        sum_array_rec(a, p, r) + sum_array_rec(a, r, q)
    }
}
/*** endif */
/*** if label == "regions_tail" */
#[no_mangle]
pub fn regions_tail(i : i64, n : i64, ri : i64) -> i64 {
    if i == n {
        ri
    } else {
        let riplus1 = ri + i + 1;
        regions_tail(i + 1, n, riplus1)
    }
}
/*** endif */
/*** if label == "sum_array_tail_rec" */
#[no_mangle]
pub fn sum_array_floats_tail_rec(a : &[f64], i : usize, n : usize, s : f64) -> f64 {
    if i == n {
        s
    } else {
        sum_array_floats_tail_rec(a, i + 1, n, s + a[i])
    }
}
/*** endif */
/*** if label == "sum_array_loop" */
#[no_mangle]
pub fn sum_array_floats_loop(a : &[f64], n : usize) -> f64 {
    let mut s = 0.0;
    for i in 0..n {
        s += a[i];
    }
    s
}
/*** endif */
/*** if 0 */
pub fn main() {
    
}
/*** endif */
