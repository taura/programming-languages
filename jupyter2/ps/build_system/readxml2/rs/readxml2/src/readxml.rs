use std::fs;
extern crate minidom;
use minidom::Element;

pub fn parse(filename: &str) -> Element {
    let dat = fs::read_to_string(filename).unwrap();
    dat.parse().unwrap()
}

pub fn height(e: &Element) -> usize {
    if e.children().count() == 0 {
	1
    } else {
	1 + e.children().map(|c| height(c)).max().unwrap()
    }
}
