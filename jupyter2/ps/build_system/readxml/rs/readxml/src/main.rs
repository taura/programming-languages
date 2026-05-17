use std::env;
use std::fs;
extern crate minidom;
use minidom::Element;

fn parse(filename: &str) -> Element {
    let dat = fs::read_to_string(filename).unwrap();
    dat.parse().unwrap()
}

fn height(e: &Element) -> usize {
    if e.children().count() == 0 {
	1
    } else {
	1 + e.children().map(|c| height(c)).max().unwrap()
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let filename = &args[1];
    let doc = parse(filename);
    let d = height(&doc);
    println!("{}", d);
}

