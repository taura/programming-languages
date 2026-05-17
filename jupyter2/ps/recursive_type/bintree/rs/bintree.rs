/** begin my answer */

/** begin hidden */
enum BinTree {
    Empty,
    Node {
	left:  Box<BinTree>,
	right: Box<BinTree>
    },
}

fn mk_maximally_balanced_bintree(n : i64) -> BinTree {
    if n == 0 {
	BinTree::Empty
    } else {
	let ls = n / 2;
	let rs = n - 1 - ls;
	let l = mk_maximally_balanced_bintree(ls);
	let r = mk_maximally_balanced_bintree(rs);
	BinTree::Node { left: Box::new(l), right: Box::new(r) }
    }
}

fn count_nodes(t : BinTree) -> i64 {
    match t {
	BinTree::Empty => 0,
	BinTree::Node { left: l, right: r } => {
	    let lc = count_nodes(*l);
	    let rc = count_nodes(*r);
	    if lc != -1 && rc != -1 && (lc == rc || lc == rc + 1) {
		1 + lc + rc
	    } else {
		-1
	    }
	}
    }
}
/** end hidden */
/** end my answer */

fn main() {
    assert!(count_nodes(mk_maximally_balanced_bintree(10))       == 10);
    assert!(count_nodes(mk_maximally_balanced_bintree(100))      == 100);
    assert!(count_nodes(mk_maximally_balanced_bintree(1000))     == 1000);
    assert!(count_nodes(mk_maximally_balanced_bintree(10000))    == 10000);
    assert!(count_nodes(mk_maximally_balanced_bintree(100000))   == 100000);
    assert!(count_nodes(mk_maximally_balanced_bintree(1000000))  == 1000000);
    println!("OK")
}
