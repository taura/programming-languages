// ---------- random number generator state ----------

struct RandState {
    x : u64
}

// next number
fn next(rg : &mut RandState) -> u64 {
    let x = rg.x;
    let a = 0x5DEECE66D as u64;
    let c = 0xB as u64;
    let m = ((1 as u64) << 48) - 1;
    rg.x = a.wrapping_mul(x).wrapping_add(c) & m;
    rg.x >> 17
}

// ---------- binary search tree ----------

enum BinSearchTree {
    Empty,
    Node{val: u64, lc: u64, left: Box<BinSearchTree>, rc: u64, right: Box<BinSearchTree>}
}

// insert x to a tree
fn insert(t : BinSearchTree, x: u64) -> BinSearchTree {
    match t {
        BinSearchTree::Empty =>
            BinSearchTree::Node{val: x,
				lc: 0,
                                left: Box::new(BinSearchTree::Empty),
				rc: 0,
                                right: Box::new(BinSearchTree::Empty)},
        BinSearchTree::Node{val, lc, left, rc, right} => 
            if x <= val {
                BinSearchTree::Node{val: val, lc: lc + 1, left: Box::new(insert(*left, x)), rc, right}
            } else {
                BinSearchTree::Node{val: val, lc, left, rc: rc + 1, right: Box::new(insert(*right, x))}
            }
    }
}

// remove the nth element in the tree (0-based), and return the removed value and the new tree
fn remove_nth(t : BinSearchTree, n : u64) -> (u64, BinSearchTree) {
    match t {
	BinSearchTree::Empty => panic!("remove_nth: empty tree"),
	BinSearchTree::Node{val, lc, left, rc, right} =>
	    if n < lc {
		let (val_, left_) = remove_nth(*left, n);
		(val_, BinSearchTree::Node{val, lc: lc - 1, left: Box::new(left_), rc, right})
	    } else if n == lc {
		if lc < rc {
		    let (val_, right_) = remove_nth(*right, 0);
		    (val, BinSearchTree::Node{val: val_, lc, left, rc: rc - 1, right: Box::new(right_)})
		} else {
		    match *left {
			BinSearchTree::Empty => (val, BinSearchTree::Empty),
			_ => {
			    let (val_, left_) = remove_nth(*left, lc - 1);
			    (val, BinSearchTree::Node{val: val_, lc: lc - 1, left: Box::new(left_), rc, right})
			}
		    }
		}
	    } else {
		let (val_, right_) = remove_nth(*right, n - lc - 1);
		(val_, BinSearchTree::Node{val, lc, left, rc: rc - 1, right: Box::new(right_)})
	    }
    }
}

// dump the first n elements in the tree
fn dump(t : BinSearchTree, n : u64) {
    match t {
	BinSearchTree::Empty => (),
	BinSearchTree::Node{val, lc, left, rc : _, right} =>
	    if n > 0 {
		dump(*left, n);
		if lc < n {
		    print!("{} ", val);
		    if lc + 1 < n {
			dump(*right, n - lc - 1);
		    }
		}
	    }
    }
}

fn main() {
    println!("lang = rust");
    let args : Vec<String> = std::env::args().collect();
    let argc = args.len();
    let m = if argc > 1 { args[1].parse::<usize>().unwrap() } else { 100_000 };
    let n = if argc > 2 { args[2].parse::<usize>().unwrap() } else { m / 2 };
    let mut rg = RandState{x: 123456};
    println!("make a tree of m = {} nodes", m);
    let mut t = BinSearchTree::Empty;
    let mut _v : u64 = 0;
    for _i in 0..m {
        let x = next(&mut rg) % 1_000_000_000;
        t = insert(t, x);
    }
    println!("insert/delete n = {} times", n);
    let t0 = std::time::Instant::now();
    for _i in 0..n {
        let x = next(&mut rg) % 1_000_000_000;
	let k = next(&mut rg) % (m + 1) as u64;
        t = insert(t, x);
        (_v, t) = remove_nth(t, k);
    }
    let dt = t0.elapsed().as_nanos();
    print!("dump the first 5 elements in the tree : ");
    dump(t, 5);
    println!();
    println!("took {} nsec to insert/remove {} elements ({} nsec/elem)", dt, n, dt as f64 / n as f64);
}

