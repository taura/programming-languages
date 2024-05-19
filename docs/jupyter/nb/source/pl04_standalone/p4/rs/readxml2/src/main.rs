use std::env;

pub mod readxml;

fn main() {
    let args: Vec<String> = env::args().collect();
    let filename = &args[1];
    let _ = readxml::readxml(filename);
    println!("{}", "OK")
}

