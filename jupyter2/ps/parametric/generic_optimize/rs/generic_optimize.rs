/** begin my answer */

/** begin hidden */
trait Domain<T> {
    fn next(self : &mut Self) -> Option<T>;
}

#[allow(dead_code)]
struct Arange {
    a : f64,
    b : f64,
    i : i64,
    n : i64,
    dx : f64
}

fn arange(a : f64, b : f64, n : i64) -> Arange {
    Arange{a, b, i: 0, n, dx: (b - a) / ((n - 1) as f64)}
}

impl Domain<f64> for Arange {
    fn next(self : &mut Arange) -> Option<f64> {
	if self.i == self.n {
	    None
	} else {
	    let x = self.a + self.dx * (self.i as f64);
	    self.i += 1;
	    Some(x)
	}
    }
}

#[allow(dead_code)]
struct Arange2d {
    x0 : f64,
    x1 : f64,
    m  : i64,
    y0 : f64,
    y1 : f64,
    n  : i64,
    i  : i64,
    j  : i64,
    dx : f64,
    dy : f64
}

fn arange2d(x0 : f64, x1 : f64, m : i64, y0 : f64, y1 : f64, n : i64) -> Arange2d {
    Arange2d{x0, x1, m, y0, y1, n, i: 0, j: 0, dx: (x1 - x0) / ((m - 1) as f64), dy: (y1 - y0) / ((n - 1) as f64)}
}

impl Domain<(f64, f64)> for Arange2d {
    fn next(self : &mut Arange2d) -> Option<(f64, f64)> {
	if self.i == self.m {
	    None
	} else {
	    let x = self.x0 + self.dx * (self.i as f64);
	    let y = self.y0 + self.dy * (self.j as f64);
	    if self.j + 1 == self.n {
		self.i += 1;
		self.j = 0;
	    } else {
		self.j += 1;
	    }
	    Some((x, y))
	}
    }
}

fn optimize<S : Clone>(f : fn(S) -> f64, dom : &mut dyn Domain<S>) -> Option<f64> {
    match dom.next() {
	None => None,
	Some(x) => {
	    let mut miny = f(x);
	    while let Some(x) = dom.next() {
		let y = f(x);
		if y < miny {
		    miny = y;
		}
	    }
	    Some(miny)
	}
    }
}
/** end hidden */
/** end my answer */

fn very_close(a : Option<f64>, b : f64) -> bool {
    match a {
	None => false,
	Some(a) => (a - b).abs() < 1e-6
    }
}

fn main() {
    fn f0(x : f64) -> f64 { x * (x - 1.) }
    fn f1(x : f64) -> f64 { x * (x - 1.) * (x - 2.) }
    fn f2((x, y) : (f64, f64)) -> f64 { x * x + 2. * y * y + 3. * x * y }
    let mut a0 = arange(0., 1., 10000);
    let mut a1 = arange(0., 3., 10000);
    let mut a2 = arange2d(-2., 2., 10000, -2., 2., 1000);
    let y0 = optimize(f0, &mut a0);
    let y1 = optimize(f1, &mut a1);
    let y2 = optimize(f2, &mut a2);
    very_close(y0, -0.25);
    very_close(y1, -0.384900);
    very_close(y2, -0.5);
    println!("OK")
}
