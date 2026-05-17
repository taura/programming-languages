/* rs/cat/src/main.rs */
fn main() {
    // get the command line arguments
    let filename = std::env::args().nth(1).expect("Please provide a filename");
    // read the file and print its contents
    let contents = std::fs::read_to_string(filename).expect("Could not read file");
    print!("{}", contents);
}
