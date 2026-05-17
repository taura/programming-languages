/** begin my answer */

/** begin hidden */
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

fn next(rng : &mut Arange) -> Option<f64> {
    if rng.i == rng.n {
	None
    } else {
	let x = rng.a + rng.dx * (rng.i as f64);
	rng.i += 1;
	Some(x)
    }
}

fn optimize(f : fn(f64) -> f64, rng : &mut Arange) -> Option<f64> {
    match next(rng) {
	None => None,
	Some(x) => {
	    let mut miny = f(x);
	    while let Some(x) = next(rng) {
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
    let mut a0 = arange(0., 1., 10000);
    let mut a1 = arange(0., 3., 10000);
    let y0 = optimize(f0, &mut a0);
    let y1 = optimize(f1, &mut a1);
    very_close(y0, -0.25);
    very_close(y1, -0.384900);
    println!("OK")
}
