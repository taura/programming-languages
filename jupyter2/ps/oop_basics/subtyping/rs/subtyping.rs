/** begin my answer */

/** begin hidden */
trait FreeShape {
    fn area(&self) -> f64;
}

trait Shape : FreeShape {
    fn contains(&self, x: f64, y: f64) -> bool;
}

struct FreeEllipse {
    a: f64,
    b: f64,
}

fn mk_free_ellipse(a: f64, b: f64) -> FreeEllipse {
    FreeEllipse { a, b }
}

impl FreeShape for FreeEllipse {
    fn area(&self) -> f64 {
	std::f64::consts::PI * self.a * self.b
    }
}

struct Ellipse {
    a: f64,
    b: f64,
    x0: f64,
    y0: f64,
}

fn mk_ellipse(a: f64, b: f64, x0: f64, y0: f64) -> Ellipse {
    Ellipse { a, b, x0, y0 }
}

impl FreeShape for Ellipse {
    fn area(&self) -> f64 {
	std::f64::consts::PI * self.a * self.b
    }
}

impl Shape for Ellipse {
    fn contains(&self, x: f64, y: f64) -> bool {
	let a = self.a;
	let b = self.b;
	let dx = x - self.x0;
	let dy = y - self.y0;
	(dx * dx) / (a * a) + (dy * dy) / (b * b) <= 1.0
    }
}

struct FreeRect {
    w: f64,
    h: f64,
}

fn mk_free_rect(w: f64, h: f64) -> FreeRect {
    FreeRect { w, h }
}

impl FreeShape for FreeRect {
    fn area(&self) -> f64 {
	self.w * self.h
    }
}

struct Rect {
    w: f64,
    h: f64,
    x0: f64,
    y0: f64,
}

fn mk_rect(w: f64, h: f64, x0: f64, y0: f64) -> Rect {
    Rect { w, h, x0, y0 }
}

impl FreeShape for Rect {
    fn area(&self) -> f64 {
	self.w * self.h
    }
}

impl Shape for Rect {
    fn contains(&self, x: f64, y: f64) -> bool {
	x >= self.x0 && x <= self.x0 + self.w && y >= self.y0 && y <= self.y0 + self.h
    }
}

fn smaller(s0: &dyn FreeShape, s1: &dyn FreeShape) -> i64 {
    if s0.area() <= s1.area() {
	0
    } else {
	1
    }
}

fn mk_free_shapes() -> Vec<Box<dyn FreeShape>> {
    vec![
	Box::new(mk_free_ellipse(16., 5.)),
	Box::new(mk_free_rect(16., 5.)),
	Box::new(mk_free_ellipse(6., 3.)),
	Box::new(mk_free_rect(6., 3.))
    ]
}

fn mk_shapes() -> Vec<Box<dyn Shape>> {
    vec![
	Box::new(mk_ellipse(16., 5., -15., -4.)),
	Box::new(mk_rect(16., 5., -15., -4.)),
	Box::new(mk_ellipse(6., 3., -3., -2.)),
	Box::new(mk_rect(6., 3., -3., -2.))
    ]
}

fn mk_mixed_shapes() -> Vec<Box<dyn FreeShape>> {
    vec![
	Box::new(mk_free_ellipse(16., 5.)),
	Box::new(mk_free_rect(16., 5.)),
	Box::new(mk_free_ellipse(6., 3.)),
	Box::new(mk_free_rect(6., 3.)),
	Box::new(mk_ellipse(16., 5., -15., -4.)),
	Box::new(mk_rect(16., 5., -15., -4.)),
	Box::new(mk_ellipse(6., 3., -3., -2.)),
	Box::new(mk_rect(6., 3., -3., -2.))
    ]
}

fn sum_area(seq: &[Box<dyn FreeShape>]) -> f64 {
    let mut s = 0.;
    for sh in seq {
	s += sh.area();
    }
    s
}

fn count_contains(seq: &[Box<dyn Shape>], x: f64, y: f64) -> i64 {
    let mut c = 0;
    for sh in seq {
	if sh.contains(x, y) {
	    c += 1;
	}
    }
    c
}

/** end hidden */
/** end my answer */

fn very_close(x: f64, y: f64) -> bool {
	(x - y).abs() < 1e-6
}

fn main() {
    let e0 = mk_free_ellipse(16., 5.);
    let r0 = mk_free_rect(16., 5.);
    let e1 = mk_free_ellipse( 6., 3.);
    let r1 = mk_free_rect( 6., 3.);
    let d0 = mk_ellipse(16., 5., -15., -4.);
    let q0 = mk_rect(16., 5., -15., -4.);
    let d1 = mk_ellipse( 6., 3.,  -3., -2.);
    let q1 = mk_rect( 6., 3.,  -3., -2.);
    assert!(very_close(e0.area(), 251.327412));
    assert!(very_close(r0.area(), 80.));
    assert!(very_close(e1.area(), 56.548668));
    assert!(very_close(r1.area(), 18.));
    assert!(very_close(d0.area(), 251.327412));
    assert!(very_close(q0.area(), 80.));
    assert!(very_close(d1.area(), 56.548668));
    assert!(very_close(q1.area(), 18.));
    assert!(smaller(&e0, &e1) == 1);
    assert!(smaller(&e0, &r0) == 1);
    assert!(smaller(&d1, &q0) == 0);
    assert!(smaller(&e0, &d0) == 0);
    let s0 = mk_free_shapes();
    let s1 = mk_shapes();
    let s2 = mk_mixed_shapes();
    // un-comment only lines below that run successfully
    // assert!(count_contains(&s0, 0.0, 0.0) == 3);
    assert!(count_contains(&s1, 0.0, 0.0) == 3);
    // assert!(count_contains(&s2, 0.0, 0.0) == 3);
    assert!(very_close(sum_area(&s0), 405.876080));
    // assert!(very_close(sum_area(&s1), 405.876080));
    assert!(very_close(sum_area(&s2), 811.752160));
    println!("OK")
}
