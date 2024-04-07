/*** if label == "Define data structure representing a rectangle and an ellipse" */
struct Rect {
    x : i32,
    y : i32,
    width : i32,
    height : i32
}

struct Ellipse {
    cx : i32,
    cy : i32,
    rx : i32,
    ry : i32
}
/*** endif */
/*** if label == "Define a method that computes the area of rect/ellipse" */
impl Rect {
    fn area(&self) -> f64 {
        (self.width * self.height) as f64
    }
}

impl Ellipse {
    fn area(&self) -> f64 {
        std::f64::consts::PI * ((self.rx * self.ry) as f64)
    }
}
/*** endif */
/*** if 0 */
#[allow(dead_code,unused_variables)]
fn use_shapes() -> i32 {
    let r = Rect{x: 0, y: 0, width: 100, height: 100};
    let e = Ellipse{cx: 0, cy: 0, rx: 100, ry: 50};
    r.area();
    e.area();
    r.x + r.y + r.width + r.height + e.cx + e.cy + e.rx + e.ry
}
/*** endif */
/*** if label == "Create an array/a list/a vector/a slice" */
trait Shape {
    fn area(&self) -> f64;
}

impl Shape for Rect {
    fn area(&self) -> f64 {
        (self.width * self.height) as f64
    }
}

impl Shape for Ellipse {
    fn area(&self) -> f64 {
        std::f64::consts::PI * ((self.rx * self.ry) as f64)
    }
}

#[allow(unused_variables)]
fn mk_shapes() {
    let r = Rect{x: 0, y:0, width: 100, height: 100};
    let e = Ellipse{cx: 0, cy: 0, rx: 100, ry: 50};
    let shapes : Vec<&dyn Shape> = vec![&r, &e];
    return;
}
/*** endif */
/*** if 0 */
#[allow(dead_code)]
fn use_mk_shapes() {
    mk_shapes()
}
/*** endif */
/*** if label == "Scan an array of shapes" */
fn sum_area(shapes : Vec<&dyn Shape>) -> f64 {
    let mut sa = 0.0;
    for (_, s) in shapes.iter().enumerate() {
        sa += s.area()
    }
    sa
}
fn main() {
    let r = Rect{x: 0, y:0, width: 100, height: 100};
    let e = Ellipse{cx: 0, cy: 0, rx: 100, ry: 50};
    let shapes : Vec<&dyn Shape> = vec![&r, &e];
    println!("{}", sum_area(shapes));
}
/*** endif */
