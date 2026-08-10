mod ast;
mod codegen;
mod lex;
mod parse;

use std::fs;
use std::io::{self, Read, Write};
use std::process::exit;

fn run() -> Result<(), String> {
    let args: Vec<String> = std::env::args().collect();

    let src = if args.len() > 1 {
        fs::read_to_string(&args[1]).map_err(|e| e.to_string())?
    } else {
        let mut s = String::new();
        io::stdin().read_to_string(&mut s).map_err(|e| e.to_string())?;
        s
    };

    let prog = parse::parse_string(&src)?;
    let asm = codegen::gen_program(&prog)?;

    if args.len() > 2 {
        let mut f = fs::File::create(&args[2]).map_err(|e| e.to_string())?;
        f.write_all(asm.as_bytes()).map_err(|e| e.to_string())?;
    } else {
        io::stdout()
            .write_all(asm.as_bytes())
            .map_err(|e| e.to_string())?;
    }
    Ok(())
}

fn main() {
    if let Err(e) = run() {
        eprintln!("{}", e);
        exit(1);
    }
}
