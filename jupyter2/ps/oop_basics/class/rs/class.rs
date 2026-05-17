/** begin my answer */

/** begin hidden */
struct FreeEllipse {
    a: f64,
    b: f64,
}

fn mk_free_ellipse(a: f64, b: f64) -> FreeEllipse {
    FreeEllipse { a, b }
}

impl FreeEllipse {
    fn area(&self) -> f64 {
	std::f64::consts::PI * self.a * self.b
    }
}

fn smaller(s0: &FreeEllipse, s1: &FreeEllipse) -> i64 {
    if s0.area() <= s1.area() {
	0
    } else {
	1
    }
}
/** end hidden */
/** end my answer */

fn very_close(x: f64, y: f64) -> bool {
	(x - y).abs() < 1e-6
}

fn main() {
    let e0 = mk_free_ellipse(16., 5.);
    let e1 = mk_free_ellipse( 6., 3.);
    assert!(very_close(e0.area(), 251.327412));
    assert!(very_close(e1.area(), 56.548668));
    assert!(smaller(&e0, &e1) == 1);
    println!("OK")
}
