/*** if 0 */
#[allow(dead_code)]
/*** endif */
/*** if label == "A function that takes a function"  */
fn f(g : fn (f64) -> f64) -> f64 { g(1.0) }
/*** endif */
/*** if label == "A domain class for a floating point number"  */
extern crate rand;
use rand::Rng;

struct RandomFloatGenerator {
    a : f64,
    b : f64,
    n : i32,
    i : i32,
    rng : rand::rngs::ThreadRng
}

fn mk_random_float_generator(a : f64, b : f64, n : i32)
                           -> RandomFloatGenerator {
    let rng = rand::thread_rng();
    let i = 0;
    RandomFloatGenerator{a, b, n, i, rng}
}

impl RandomFloatGenerator {
    fn next(&mut self) -> Option<f64> {
        if self.i < self.n {
            let x = self.a + (self.b - self.a) * self.rng.gen::<f64>();
            self.i += 1;
            return Some(x)
        } else {
            return None
        }
    }
}
/*** endif */
/*** if label == "A minimizer for float -> float functions" */
fn take_min(min_xy : Option::<(f64, f64)>, x : f64, y : f64)
            -> Option::<(f64, f64)> {
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

fn minimize(f : fn (f64) -> f64, rfg : &mut RandomFloatGenerator)
            -> Option::<(f64, f64)> {
    let mut min_xy : Option::<(f64, f64)> = None;
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
/*** endif */
/*** if label == "Apply float -> float minimizer" */
fn main() {
    fn f(x : f64) -> f64 { x * (x - 1.0) * (x - 2.0) }
    let mut rfg = mk_random_float_generator(0.0, 2.0, 1000);
    match minimize(f, &mut rfg) {
        Some((x, y)) => println!("{} {}", x, y),
        None => println!("")
    }
}
/*** endif */
