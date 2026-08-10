fn main() {
    let args : Vec<String> = std::env::args().collect();
    let argc = args.len();
    let s = if argc > 1 { args[1].parse::<usize>().unwrap() } else { 1_000_000 };
    let m = if argc > 2 { args[2].parse::<usize>().unwrap() } else { 100 };
    let n = if argc > 3 { args[3].parse::<usize>().unwrap() } else { m * 10 };
    let sizeof_elem = 8;
    if sizeof_elem * s * m > (1 << 30) {
        println!("you'd better not allocate that much memory");
        println!("sizeof element(8) * s({}) * m({}) = {} > 1GB", s, m, sizeof_elem * s * m);
        std::process::exit(1)
    }
    let b = Box::new(vec![0i64; s]);
    let mut a = Box::new(vec![b; m]);
    for i in 0..n {
        let b = Box::new(vec![0i64; s]);
        let p = b.as_ptr() as usize;
        a[i % m] = b;
        println!("{}\t{}", i, p);
    }
}
