/** begin my answer */

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
