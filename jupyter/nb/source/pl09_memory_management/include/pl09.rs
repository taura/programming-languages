/*** if label == "measure_time" */
fn time_ns(now : &std::time::Instant) -> i64 {
    now.elapsed().as_nanos() as i64
}
/*** endif */
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
/*** if label == "measure_time" */
    let ts = std::time::Instant::now();
/*** endif */
    for i in 0..n {
/*** if label == "measure_time" */
        let t0 = time_ns(&ts);
/*** endif */
        let b = Box::new(vec![0i64; s]);
/*** if label == "show_addr" or label == "measure_time" */
        let p = b.as_ptr() as usize;
/*** endif */
        a[i % m] = b;
/*** if label == "measure_time" */
        let t1 = time_ns(&ts);
/*** endif */
/*** if label == "show_addr" */
        println!("{}\t{}", i, p);
/*** endif */
/*** if label == "measure_time" */
        println!("{}\t{}\t{}", i, p, t1 - t0);
/*** endif */
    }
}
