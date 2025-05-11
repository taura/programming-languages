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
/*** endif */
/*** if label == "A somewhat generic float -> float minimizer" */
trait FloatGenerator {
    fn next(&mut self) -> Option<f64>;
}

impl FloatGenerator for RandomFloatGenerator {
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

fn minimize(f : fn (f64) -> f64, rfg : &mut dyn FloatGenerator)
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
/*** if label == "Apply a somewhat generic float -> float minimizer" */
fn main() {
    fn f(x : f64) -> f64 { x * (x - 1.0) * (x - 2.0) }
    let mut rfg = mk_random_float_generator(0.0, 2.0, 1000);
    match minimize(f, &mut rfg) {
        Some((x, y)) => println!("{} {}", x, y),
        None => println!("")
    }
}
/*** endif */
/*** if label == "Define a trivial generic type and a function" */
struct Triv<T> {
    x : T
}
fn triv_val<T>(t : Triv::<T>) -> T {
    t.x
}
/*** endif */
/*** if 0 */
#[allow(dead_code)]
fn use_triv() -> i32 {
    let t = Triv{x: 3};
    triv_val(t)
}
/*** endif */
