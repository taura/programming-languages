#![allow(dead_code)]

use std::io::Write;

// utility

fn max(x : usize, y : usize) -> usize {
    if x < y { y } else { x }
}

fn swap(a : &mut Vec<Event>, i : usize, j : usize) {
    let ai = a[i];
    let aj = a[j];
    a[j] = ai;
    a[i] = aj;
}

// allocation record that records how long an allocation took
#[derive(Clone,Copy)]
struct Event {
    stamp : i64,		// when it happened
    dt : i64                    // how long it took
}

// heap data structure that keeps track of longest m allocations
// (this heap should not be confused with heap memory of programming languages).
struct EventHeap {
    n : i64,               // actual no of elements
    a : Vec<Event>,        // vector of events
    // invariant a[p] < a[2p+1], a[p] < a[2p+2]
    start_stamp : std::time::Instant
}

// create a heap of m Events
fn mk_heap(m : usize) -> EventHeap {
    EventHeap{n: 0, a: vec![Event{stamp: 0, dt: 0}; m], start_stamp: std::time::Instant::now()}
}

// add an element x to heap h
fn add(h : &mut EventHeap, x : Event) {
    let n = h.n as usize;
    let a = &mut h.a;
    assert!(n < a.len());
    let n = n + 1;
    a[n - 1] = x;
    let mut c = n - 1;
    while c > 0 {
	let p = (c - 1) / 2;
	if a[c].dt < a[p].dt {
            swap(a, c, p);
	}
	c = p
    }
    h.n = n as i64;
    //check_event_heap(h)
}

// remove the smallest element from h
fn remove_smallest(h : &mut EventHeap) -> Event {
    let n = h.n as usize;
    let a = &mut h.a;
    assert!(n > 0);
    let x = a[0];
    a[0] = a[n - 1];
    let n = n - 1;
    let mut p : usize = 0;
    while 2 * p + 1 < n {
	let l = 2 * p + 1;
	let r = 2 * p + 2;
	let c;
	if r < n && a[r].dt < a[l].dt {
	    c = r;
	} else {
	    c = l;
	}
	if a[c].dt < a[p].dt {
            swap(a, c, p);
	}
	p = c;
    }
    h.n = n as i64;
    //check_event_heap(h);
    x
}

// if h has a room for another element, insert Event(no, stamp, dt)
// otherwise if dt is larger than the smallest dt in h, then
// replace it with Event(no, stamp, dt)
fn add_record(h : &mut EventHeap, dt : i64) {
    let stamp = h.start_stamp.elapsed().as_nanos() as i64;
    let m = h.a.len() as i64;
    if h.n == m && h.a[0].dt < dt { remove_smallest(h); }
    if h.n < m { add(h, Event{stamp, dt}); }
}

// debugprint heap
fn print_heap(h : &mut EventHeap, filename : &str) -> std::io::Result<()> {
    let mut wp = std::fs::File::create(filename)?;
    // writeln!(&mut wp, "stamp,dt")?;
    for _i in 0..h.n {
	let e = remove_smallest(h);
        writeln!(&mut wp, "{},{}", e.stamp, e.dt)?;
    }
    std::io::Result::Ok(())
}

// random number generator state
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

// binary search tree
enum BinSearchTree {
    Empty,
    Node{val: u64, left: Box<BinSearchTree>, right: Box<BinSearchTree>}
}

struct BSTNode {
    val : u64,
    left : Option::<Box<BSTNode>>,
    right: Option::<Box<BSTNode>>
}

type BST = Option<Box<BSTNode>>;

fn mkNode(val : u64, left : BST, right : BST) -> BST {
    Some(Box::new(BSTNode{val, left, right}))
}

// insert x to a tree
fn insertx(t : BinSearchTree, x: u64) -> BinSearchTree {
    match t {
        BinSearchTree::Empty =>
            BinSearchTree::Node{val: x,
                                left: Box::new(BinSearchTree::Empty),
                                right: Box::new(BinSearchTree::Empty)},
        BinSearchTree::Node{val, left, right} => 
            if x <= val {
                BinSearchTree::Node{val: val, left: Box::new(insertx(*left, x)), right}
            } else {
                BinSearchTree::Node{val: val, left, right: Box::new(insertx(*right, x))}
            }
    }
}

// insert x to a tree
fn insert(t : BST, x: u64) -> BST {
    match t {
        Empty => mkNode(x, None, None),
        Some(Box::new(BSTNode{val, left, right})) =>
            if x <= val {
                mkNode(val, insert(left, x), right)
            } else {
                mkNode(val, left, insert(right, x))
            }
    }
}

// remove the maximum element from a tree
fn remove_maxx(t : BinSearchTree) -> BinSearchTree {
    match t {
        BinSearchTree::Empty => BinSearchTree::Empty,
        BinSearchTree::Node{val, left, right} =>
            match *right {
                BinSearchTree::Empty => *left,
                _ => BinSearchTree::Node{val, left, right: Box::new(remove_maxx(*right))}
            }
    }
}

// remove the maximum element from a tree
fn remove_max(t : BST) -> BST {
    match t {
        None => None,
        Some(BSTNode{val, left, right}) =>
            match right {
                None => left,
                _ => Some(Box(BSTNode{val, left, right : remove_max(right)}))
            }
    }
}

// find the maximum element of a tree
fn peek_maxx(t : BinSearchTree) -> Option<u64> {
    match t {
        BinSearchTree::Empty => None,
        BinSearchTree::Node{val, left: _, right} =>
            match *right {
                BinSearchTree::Empty => Some(val),
                _ => peek_maxx(*right)
            }
    }
}

// find the maximum element of a tree
fn peek_max(t : BST) -> BST {
    match t {
        None => None,
        Some(BSTNode{val, left, right}) =>
            match right {
                None => Some(val),
                _ => peek_max(right)
            }
    }
}


fn main() -> std::io::Result<()> {
    println!("lang = rust");
    let args : Vec<String> = std::env::args().collect();
    let argc = args.len();
    let m = if argc > 1 { args[1].parse::<usize>().unwrap() } else { 100_000 };
    let n = if argc > 2 { args[2].parse::<usize>().unwrap() } else { m / 2 };
    let n_records
        = if argc > 3 { args[3].parse::<usize>().unwrap() } else { max(n / 1000, 100) };
    let mut rg = RandState{x: 123456};
    println!("make a tree of m = {} nodes", m);
    //let mut t = BinSearchTree::Empty;
    let mut t : BSTNode = None;
    for _i in 0..m {
        let x = next(&mut rg) % 1_000_000_000;
        t = insert(t, x);
    }
    println!("insert/delete n = {} times", n);
    let mut h = mk_heap(n_records);
    let t0 = std::time::Instant::now();
    for _i in 0..n {
        let x = next(&mut rg) % 1_000_000_000;
        let s0 = std::time::Instant::now();
        t = insert(t, x);
        t = remove_max(t);
        let ds = s0.elapsed().as_nanos() as i64;
        add_record(&mut h, ds);
    }
    let dt = t0.elapsed().as_nanos();
    match peek_max(t) {
        None => println!(),
        Some(v) => println!("{} th smallest value out of {} values v = {}",
                            m, m + n, v)
    }
    println!("took {} nsec to insert/remove {} elements", dt, n);
    let alloc_log = "allocation-rust.csv";
    println!("dump {} records that took longest to {}", n_records, alloc_log);
    print_heap(&mut h, alloc_log)
}

