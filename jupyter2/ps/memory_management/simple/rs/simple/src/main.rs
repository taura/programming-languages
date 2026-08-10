fn main() {
    let args : Vec<String> = std::env::args().collect();
    let argc = args.len();
    let s = if argc > 1 { args[1].parse::<usize>().unwrap() } else { 1_000_000 };
    let m = if argc > 2 { args[2].parse::<usize>().unwrap() } else { 10 };
    let n = if argc > 3 { args[3].parse::<usize>().unwrap() } else { m * 10 };
    let b = Box::new(vec![0; 1]);
    let mut a = Box::new(vec![b; m]);
    for i in 0..n {
        let b = Box::new(vec![i; s]);
        a[i % m] = b;
    }
    println!("a[0][0] = {}", a[0][0]);
}

