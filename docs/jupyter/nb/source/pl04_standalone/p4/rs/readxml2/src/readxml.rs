use std::fs;
extern crate minidom;
use minidom::Element;

pub fn readxml(filename : &str) -> Element {
    let dat = fs::read_to_string(filename).unwrap();
    let el: Element = dat.parse().unwrap();
    el
}
