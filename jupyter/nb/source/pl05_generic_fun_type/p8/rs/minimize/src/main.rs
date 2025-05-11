extern crate rand;
use rand::Rng;

trait Generator<T : Copy> {
    fn next(&mut self) -> Option<T>;
}

fn take_min<T : Copy>(min_xy : Option::<(T, f64)>, x : T, y : f64)
                      -> Option::<(T, f64)> {
    match min_xy {
        None => Some((x, y)),
        Some((_, min_y)) =>
            if y < min_y {
                Some((x, y))
            } else {
                min_xy
            }
    }
}

fn minimize<T : Copy>(f : fn (T) -> f64, rfg : &mut dyn Generator<T>)
            -> Option::<(T, f64)> {
    let mut min_xy : Option::<(T, f64)> = None;
    loop {
        match rfg.next() {
            None => break,
            Some(x) => {
                let y = f(x);
                min_xy = take_min(min_xy, x, y);
            }
        }
    }
    min_xy
}

struct EllipseGenerator {
    x0 : f64,
    y0 : f64,
    a : f64,
    b : f64,
    n : i32,
    i : i32,
    rng : rand::rngs::ThreadRng
}

fn mk_ellipse_generator(x0 : f64, y0 : f64, a : f64, b : f64, n : i32)
                           -> EllipseGenerator {
    let rng = rand::thread_rng();
    let i = 0;
    EllipseGenerator{x0, y0, a, b, n, i, rng}
}

impl Generator::<(f64, f64)> for EllipseGenerator {
    fn next(&mut self) -> Option<(f64, f64)> {
        if self.i < self.n {
            loop {
                let rx = -1.0 + 2.0 * self.rng.gen::<f64>();
                let ry = -1.0 + 2.0 * self.rng.gen::<f64>();
                if rx * rx + ry * ry < 1.0 {
                    let x = self.x0 + self.a * rx;
                    let y = self.y0 + self.b * ry;
                    self.i += 1;
                    return Some((x, y))
                }
            }
        } else {
            return None
        }
    }
}

fn main() {
    fn f(x : (f64, f64)) -> f64 { x.0 * x.0 + x.1 * x.1 }
    let mut eg = mk_ellipse_generator(3.0, 3.0, 2.0, 1.0, 10000);
    match minimize(f, &mut eg) {
        Some((x, y)) => println!("(x, y) = ({:.6}, {:.6}), f(x, y) = {:.6}", x.0, x.1, y),
        None => println!("")
    }
}

