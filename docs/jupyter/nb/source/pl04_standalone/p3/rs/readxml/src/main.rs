use std::env;
use std::fs;
extern crate minidom;
use minidom::Element;

fn main() {
    let args: Vec<String> = env::args().collect();
    let filename = &args[1];
    let dat = fs::read_to_string(filename).unwrap();
    let _: Element = dat.parse().unwrap();
    println!("{}", "OK")
}

