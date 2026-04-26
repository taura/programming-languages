/** begin my answer */

/** end my answer */

/** add all values in list xs to tree t in order */
fn add_seq(xs : &[i64], mut t : BinHeap) -> BinHeap {
    for x in xs {
	t = binheap_add(*x, t);
    }
    t
}

/** remove all values from t and push them in front of xs */
fn binheap_to_seq(mut t : BinHeap) -> Vec<i64> {
    let mut xs = vec![];
    while let BinHeap::Node { .. } = t {
	let (x, t_) = binheap_remove_min(t);
	xs.push(x);
	t = t_;
    }
    xs
}

/** 0 ... n - 1 */
fn range(n : i64) -> Vec<i64> {
    (0..n).collect()
}

/** random sequence */
fn random_seq(n : i64, mut x : i64) -> Vec<i64> {
    let mut s = vec![];
    for _i in 0..n {
        x = (x.wrapping_mul(0x5DEECE66D) + 0xB) & 0xFFFFFFFFFFFF;
        s.push(x >> 17)
    }
    s
}

/** randomly shuffle xs */
fn random_shuffle(seed : i64, xs : Vec<i64>) -> Vec<i64> {
    let ys = random_seq(xs.len() as i64, seed);
    let mut zs : Vec<(i64,i64)> = ys.iter().copied().zip(xs.iter().copied()).collect();
    zs.sort();
    zs.into_iter().map(|(_k, x)| x).collect()
}

/**
add xs to empty tree; remove all elements from the tree;
check if they are sorted
 */

fn print_vec(header : &str, v : &[i64], n : usize) {
    print!("{}[", header);
    for (i, x) in v.iter().enumerate() {
	if i >= n {
	    print!("...");
	    break;
	}
	if i > 0 {
	    print!(", ");
	}
	print!("{}", x);
    }
    println!("]");
}

fn check_seq(xs : &[i64]) -> bool {
    print_vec("input:  ", &xs, 7);
    let t = add_seq(xs, empty());
    let ys = binheap_to_seq(t);
    print_vec("output: ", &ys, 7);
    let mut zs = xs.to_vec();
    zs.sort();
    ys == zs
}

/** randomly shuffle 0 .. n-1;
add them to empty tree;
remove all elements from the tree;
check they are sorted
 */

fn check_random(seed : i64, n : i64) -> bool {
    let rng = range(n);
    let xs = random_shuffle(seed, rng);
    check_seq(&xs)
}

fn main() {
    let seed = 12345;
    assert!(check_random(seed, 2));
    assert!(check_random(seed, 3));
    assert!(check_random(seed, 4));
    assert!(check_random(seed, 5));
    assert!(check_random(seed, 10));
    assert!(check_random(seed, 100));
    assert!(check_random(seed, 1000));
    assert!(check_random(seed, 10000));
    assert!(check_random(seed, 100000));
    println!("OK")
}

