#![allow(dead_code)]

// (1)
#[no_mangle]
fn add_nums(x: i64, y: i64) -> i64 {
    x + y + 123
}

#[no_mangle]
fn add_ints(x: i64, y: i64) -> i64 {
    x + y + 123
}

#[no_mangle]
fn add_floats(x: f64, y: f64) -> f64 {
    x + y
}

// (2)

struct Point {
    x : f64,
    y : f64
}

#[no_mangle]
fn get_point_y(p : Point) -> f64 {
    p.y
}

#[no_mangle]
fn get_point_y_ref(p : &Point) -> f64 {
    p.y
}

#[no_mangle]
fn get_point_y_box(p : Box<Point>) -> f64 {
    p.y
}

// (3)

#[no_mangle]
fn get_float_array3_elem_const(a : &[f64; 3]) -> f64 {
    a[2]
}

#[no_mangle]
fn get_float_array3_elem_var(a : &[f64; 3], i : usize) -> f64 {
    a[i]
}

#[no_mangle]
fn get_float_slice_elem_const(a : &[f64]) -> f64 {
    a[2]
}

#[no_mangle]
fn get_float_slice_elem_var(a : &[f64], i : usize) -> f64 {
    a[i]
}

// (4)

#[no_mangle]
fn collatz(n : i64) -> i64 {
    if n % 2 == 0 {
	n / 2
    } else {
	3 * n + 1
    }
}

#[no_mangle]
fn gcd1(a : i64, b : i64) -> i64 {
    if b == 0 {
	a
    } else {
	a % b
    }
}

// (5)

#[no_mangle]
fn sum_array_loop(a : &[f64], n : usize) -> f64 {
    let mut s = 0.0;
    for i in 0..n {
	s += a[i];
    }
    s
}

// (6)

#[no_mangle]
fn call_tanh(x : f64) -> f64 {
    (x + 1.0).tanh() + x
}

// (7)

#[no_mangle]
fn sum_array_rec(a : &[f64], n : usize) -> f64 {
    if n == 0 {
	0.0
    } else {
	sum_array_rec(a, n - 1) + a[n]
    }
}

// (8)

#[no_mangle]
fn sum_array_tail(a : &[f64], i : usize, n : usize, s : f64) -> f64 {
    if i == n {
	s
    } else {
	sum_array_tail(a, i + 1, n, s + a[i])
    }
}

// (9)

#[no_mangle]
fn mk_point(x : f64, y : f64) -> Point {
    Point { x: x + 1.0, y: y + 2.0 }
}

#[no_mangle]
fn mk_point_box(x : f64, y : f64) -> Box<Point> {
    Box::new(Point { x: x + 1.0, y: y + 2.0 })
}

// (10)

#[no_mangle]
fn mk_array_10(x : f64) -> [f64; 10] {
    [x, x, x, x, x, x, x, x, x, x]
}

#[no_mangle]
fn mk_vec_10(x : f64) -> Vec<f64> {
    vec![x, x, x, x, x, x, x, x, x, x]
}

// (11)

trait Shape {
    fn area(&self) -> f64;
}

#[no_mangle]
fn call_area(s : &dyn Shape) -> f64 {
    s.area()
}

