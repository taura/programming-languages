use std::env;
mod readxml;

fn main() {
    let args: Vec<String> = env::args().collect();
    let filename = &args[1];
    let doc = readxml::parse(filename);
    let d = readxml::height(&doc);
    println!("{}", d);
}

