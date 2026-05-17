/** begin my answer */

/** begin hidden */
#[derive(Debug)]
enum BinHeap {
    Empty,
    Node {
	x:  i64,
	lc: i64,
	l:  Box<BinHeap>,
	rc: i64,
	r:  Box<BinHeap>,
    },
}

fn complete_bintree(n : i64) -> bool {
    (n & (n + 1)) == 0
}

fn empty() -> BinHeap {
    BinHeap::Empty
}
fn box_empty() -> Box<BinHeap> {
    Box::new(empty())
}

fn binheap_add(x : i64, t : BinHeap) -> BinHeap {
    match t {
	BinHeap::Empty => BinHeap::Node{x, lc: 0, l: box_empty(), rc: 0, r: box_empty()},
	BinHeap::Node { x: y, lc, l, rc, r } => {
	    assert!(lc >= rc);
	    let (u, v) = if x < y { (x, y) } else { (y, x) };
	    if complete_bintree(lc) && lc > rc {
		// left is perfect; add to right
		BinHeap::Node { x: u, lc, l, rc: rc + 1, r: Box::new(binheap_add(v, *r)) }
	    } else {
		// add to left
		BinHeap::Node { x: u, lc: lc + 1, l: Box::new(binheap_add(v, *l)), rc, r }
	    }
	}
    }
}
    
fn binheap_remove_rightmost_leaf(t : BinHeap) -> (i64, BinHeap) {
    match t {
	BinHeap::Empty => (-1, empty()),
	BinHeap::Node { x, lc, l, rc, r } => {
	    if lc == 0 && rc == 0 {
		(x, empty())
	    } else if complete_bintree(lc) && lc < 2 * rc + 1 {
		// remove from right
		let (y, r_) = binheap_remove_rightmost_leaf(*r);
		assert!(y != -1);
		(y, BinHeap::Node { x, lc, l, rc: rc - 1, r: Box::new(r_) })
	    } else {
		// remove from left
		let (y, l_) = binheap_remove_rightmost_leaf(*l);
		(y, BinHeap::Node { x, lc: lc - 1, l: Box::new(l_), rc, r })
	    }
	}
    }
}

fn binheap_fix(x : i64, lc: i64, l: Box<BinHeap>, rc: i64, r: Box<BinHeap>) -> BinHeap {
    match (lc, *l, rc, *r) {
	(0, BinHeap::Empty,
	 0, BinHeap::Empty) => BinHeap::Node { x, lc, l: box_empty(), rc, r: box_empty() },
	(1, BinHeap::Node { x: y, lc: 0, l: l_, rc: 0, r: r_ },
	 0, BinHeap::Empty) => {
	    let (u, v) = if x < y { (x, y) } else { (y, x) };
	    BinHeap::Node { x: u,
			    lc: 1, l: Box::new(BinHeap::Node { x: v, lc: 0, l: l_, rc: 0, r: r_ }),
			    rc: 0, r: box_empty() }
	},
	(lc, BinHeap::Node { x: lx, lc: llc, l: ll, rc: lrc, r: lr },
	 rc, BinHeap::Node { x: rx, lc: rlc, l: rl, rc: rrc, r: rr }) => {
	    if x < lx && x < rx {
		// x is already root
		let l_ = Box::new(BinHeap::Node { x: lx, lc: llc, l: ll, rc: lrc, r: lr });
		let r_ = Box::new(BinHeap::Node { x: rx, lc: rlc, l: rl, rc: rrc, r: rr });
		BinHeap::Node { x, lc, l: l_, rc, r: r_ }
	    } else if lx < rx {
		// lx should be root x <-> lx
		let l_ = Box::new(binheap_fix(x, llc, ll, lrc, lr));
		let r_ = Box::new(binheap_fix(rx, rlc, rl, rrc, rr));
		BinHeap::Node { x: lx, lc, l: l_, rc, r: r_ }
	    } else {
		// rx should root x <-> ly
		let l_ = Box::new(binheap_fix(lx, llc, ll, lrc, lr));
		let r_ = Box::new(binheap_fix(x, rlc, rl, rrc, rr));
		BinHeap::Node { x: rx, lc, l: l_, rc, r: r_ }
	    }
	},
	(lc, l, rc, r) =>
	    panic!("broken heap lc={}, l={:?}, rc={}, r={:?}", lc, l, rc, r)
    }
}
							   
fn binheap_remove_min(t : BinHeap) -> (i64, BinHeap) {
    let (x, t) = binheap_remove_rightmost_leaf(t);
    if x == -1 {
        (-1, empty())
    } else {
	match t {
            BinHeap::Empty => (x, empty()),
	    BinHeap::Node { x: y, lc, l, rc, r } => (y, binheap_fix(x, lc, l, rc, r))
	}
    }
}

/** end hidden */
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

