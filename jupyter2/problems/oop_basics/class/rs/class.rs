/** begin my answer */

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
