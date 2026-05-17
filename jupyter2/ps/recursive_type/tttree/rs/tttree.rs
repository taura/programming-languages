/** begin my answer */

/** begin hidden */

/* non-empty two-three-tree */
enum TTTree_ {
    Leaf(i64),
    N2(Box<TTTree_>, i64, Box<TTTree_>),
    N3(Box<TTTree_>, i64, Box<TTTree_>, i64, Box<TTTree_>),
}

enum TTTree {
    Empty,
    Singleton(i64),
    TTTree(Box<TTTree_>),
}

enum TTTreeAddResult {
    T(Box<TTTree_>),                        // ordinary result
    S(Box<TTTree_>, i64, Box<TTTree_>),     // split
}

enum TTTreeRemoveResult {
    E,                          // leaf -> empty
    SC(Box<TTTree_>),           // single-child
    MC(Box<TTTree_>),           // ordinary
}

fn tttree_check_(t: &TTTree_) -> i64 {
    match t {
        TTTree_::Leaf(_) => 0,
        TTTree_::N2(u0, _, u1) => {
            let d0 = tttree_check_(u0);
            let d1 = tttree_check_(u1);
            assert!(d0 == d1);
            d0 + 1
        }
        TTTree_::N3(u0, _, u1, _, u2) => {
            let d0 = tttree_check_(u0);
            let d1 = tttree_check_(u1);
            let d2 = tttree_check_(u2);
            assert!(d0 == d1 && d1 == d2);
            d0 + 1
        }
    }
}

fn tttree_check(t: &TTTree) -> i64 {
    match t {
        TTTree::Empty => 0,
        TTTree::Singleton(_) => 1,
        TTTree::TTTree(t_) => tttree_check_(t_),
    }
}

fn tttree_add_(x: i64, t: Box<TTTree_>) -> TTTreeAddResult {
    match *t {
        TTTree_::Leaf(y) => {
            let (u, v) = if x < y { (x, y) } else { (y, x) };
            TTTreeAddResult::S(Box::new(TTTree_::Leaf(u)), v, Box::new(TTTree_::Leaf(v)))
        }
        TTTree_::N2(u0, s0, u1) => {
            //    s0
            // u0    u1
            if x < s0 {
                match tttree_add_(x, u0) {
                    TTTreeAddResult::S(u00, s00, u01) => {
                        //    s00     s0
                        // u00     u01    u1
                        TTTreeAddResult::T(Box::new(TTTree_::N3(u00, s00, u01, s0, u1)))
                    }
                    TTTreeAddResult::T(u0_) => {
                        TTTreeAddResult::T(Box::new(TTTree_::N2(u0_, s0, u1)))
                    }
                }
            } else {
                match tttree_add_(x, u1) {
                    TTTreeAddResult::S(u10, s10, u11) => {
                        //    s0     s10
                        // u0    u10     u11
                        TTTreeAddResult::T(Box::new(TTTree_::N3(u0, s0, u10, s10, u11)))
                    }
                    TTTreeAddResult::T(u1_) => {
                        TTTreeAddResult::T(Box::new(TTTree_::N2(u0, s0, u1_)))
                    }
                }
            }
        }
        TTTree_::N3(u0, s0, u1, s1, u2) => {
            //    s0    s1
            // u0    u1    u2
            if x < s0 {
                match tttree_add_(x, u0) {
                    TTTreeAddResult::S(u00, s00, u01) => {
                        //     s00     s0     s1
                        // u00     u01     u1    u2
                        TTTreeAddResult::S(
                            Box::new(TTTree_::N2(u00, s00, u01)),
                            s0,
                            Box::new(TTTree_::N2(u1, s1, u2)),
                        )
                    }
                    TTTreeAddResult::T(u0_) => {
                        TTTreeAddResult::T(Box::new(TTTree_::N3(u0_, s0, u1, s1, u2)))
                    }
                }
            } else if x < s1 {
                match tttree_add_(x, u1) {
                    //    s0     s10      s1
                    // u0    u10      u11    u2
                    TTTreeAddResult::S(u10, s10, u11) => {
                        TTTreeAddResult::S(
                            Box::new(TTTree_::N2(u0, s0, u10)),
                            s10,
                            Box::new(TTTree_::N2(u11, s1, u2)),
                        )
                    }
                    TTTreeAddResult::T(u1_) => {
                        TTTreeAddResult::T(Box::new(TTTree_::N3(u0, s0, u1_, s1, u2)))
                    }
                }
            } else {
                match tttree_add_(x, u2) {
                    TTTreeAddResult::S(u20, s20, u21) => {
                        //    s0    s1     s21
                        // u0    u1    u20     u21
                        TTTreeAddResult::S(
                            Box::new(TTTree_::N2(u0, s0, u1)),
                            s1,
                            Box::new(TTTree_::N2(u20, s20, u21)),
                        )
                    }
                    TTTreeAddResult::T(u2_) => {
                        TTTreeAddResult::T(Box::new(TTTree_::N3(u0, s0, u1, s1, u2_)))
                    }
                }
            }
        }
    }
}

fn tttree_add(x: i64, t: TTTree) -> TTTree {
    match t {
        TTTree::Empty => TTTree::Singleton(x),
        TTTree::Singleton(y) => {
            let (u, v) = if x < y { (x, y) } else { (y, x) };
            TTTree::TTTree(Box::new(TTTree_::N2(
                Box::new(TTTree_::Leaf(u)),
                v,
                Box::new(TTTree_::Leaf(v)),
            )))
        }
        TTTree::TTTree(t_) => match tttree_add_(x, t_) {
            TTTreeAddResult::S(t0, s0, t1) => TTTree::TTTree(Box::new(TTTree_::N2(t0, s0, t1))),
            TTTreeAddResult::T(t__) => TTTree::TTTree(t__),
        },
    }
}

fn tttree_lookup_(x: i64, t: &TTTree_) -> bool {
    match t {
        TTTree_::Leaf(y) => x == *y,
        TTTree_::N2(p, a, q) => {
            if x < *a {
                tttree_lookup_(x, p)
            } else {
                tttree_lookup_(x, q)
            }
        }
        TTTree_::N3(p, a, q, b, r) => {
            if x < *a {
                tttree_lookup_(x, p)
            } else if x < *b {
                tttree_lookup_(x, q)
            } else {
                tttree_lookup_(x, r)
            }
        }
    }
}

fn tttree_lookup(x: i64, t: &TTTree) -> bool {
    match t {
        TTTree::Empty => false,
        TTTree::Singleton(y) => x == *y,
        TTTree::TTTree(t_) => tttree_lookup_(x, t_),
    }
}

fn tttree_remove_(x: i64, t: Box<TTTree_>) -> TTTreeRemoveResult {
    match *t {
        TTTree_::Leaf(y) => {
            if x == y {
                TTTreeRemoveResult::E
            } else {
                TTTreeRemoveResult::MC(Box::new(TTTree_::Leaf(y)))
            }
        }
        TTTree_::N2(u0, s0, u1) => {
            if x < s0 {
                match tttree_remove_(x, u0) {
                    TTTreeRemoveResult::E => TTTreeRemoveResult::SC(u1),
                    TTTreeRemoveResult::SC(u00) => {
                        //      s0
                        //   u0    u1
                        //   |
                        //  u00
                        match *u1 {
                            TTTree_::N2(u10, s10, u11) => {
                                //       s0
                                //    u0      u1
                                //    |       /\
                                //    u00   u10 u11
                                TTTreeRemoveResult::SC(Box::new(TTTree_::N3(
                                    u00, s0, u10, s10, u11,
                                )))
                            }
                            TTTree_::N3(u10, s10, u11, s11, u12) => {
                                //       s0
                                //    u0      u1
                                //    |       /|\
                                //   u00   u10 u11 u12
                                TTTreeRemoveResult::MC(Box::new(TTTree_::N2(
                                    Box::new(TTTree_::N2(u00, s0, u10)),
                                    s10,
                                    Box::new(TTTree_::N2(u11, s11, u12)),
                                )))
                            }
                            _ => panic!("assertion failed"),
                        }
                    }
                    TTTreeRemoveResult::MC(u0_) => {
                        TTTreeRemoveResult::MC(Box::new(TTTree_::N2(u0_, s0, u1)))
                    }
                }
            } else {
                match tttree_remove_(x, u1) {
                    TTTreeRemoveResult::E => TTTreeRemoveResult::SC(u0),
                    TTTreeRemoveResult::SC(u10) => match *u0 {
                        TTTree_::N2(u00, s00, u01) => TTTreeRemoveResult::SC(Box::new(
                            TTTree_::N3(u00, s00, u01, s0, u10),
                        )),
                        TTTree_::N3(u00, s00, u01, s01, u02) => {
                            TTTreeRemoveResult::MC(Box::new(TTTree_::N2(
                                Box::new(TTTree_::N2(u00, s00, u01)),
                                s01,
                                Box::new(TTTree_::N2(u02, s0, u10)),
                            )))
                        }
                        _ => panic!("assertion failed"),
                    },
                    TTTreeRemoveResult::MC(u1_) => {
                        TTTreeRemoveResult::MC(Box::new(TTTree_::N2(u0, s0, u1_)))
                    }
                }
            }
        }
        TTTree_::N3(u0, s0, u1, s1, u2) => {
            //    s0    s1
            // u0    u1    u2
            if x < s0 {
                match tttree_remove_(x, u0) {
                    TTTreeRemoveResult::E => {
                        TTTreeRemoveResult::MC(Box::new(TTTree_::N2(u1, s1, u2)))
                    }
                    TTTreeRemoveResult::SC(u00) => match *u1 {
                        TTTree_::N2(u10, s10, u11) => {
                            //         s0    s1
                            //      u0     u1    u2
                            //      |      /\
                            //      u00  u10 u11
                            TTTreeRemoveResult::MC(Box::new(TTTree_::N2(
                                Box::new(TTTree_::N3(u00, s0, u10, s10, u11)),
                                s1,
                                u2,
                            )))
                        }
                        TTTree_::N3(u10, s10, u11, s11, u12) => {
                            //        s0       s1
                            //      u0      u1      u2
                            //       |     /|\
                            //     u00  u10 u11 u12
                            TTTreeRemoveResult::MC(Box::new(TTTree_::N3(
                                Box::new(TTTree_::N2(u00, s0, u10)),
                                s10,
                                Box::new(TTTree_::N2(u11, s11, u12)),
                                s1,
                                u2,
                            )))
                        }
                        _ => panic!("assertion failed"),
                    },
                    TTTreeRemoveResult::MC(u0_) => {
                        TTTreeRemoveResult::MC(Box::new(TTTree_::N3(u0_, s0, u1, s1, u2)))
                    }
                }
            } else if x < s1 {
                match tttree_remove_(x, u1) {
                    TTTreeRemoveResult::E => {
                        TTTreeRemoveResult::MC(Box::new(TTTree_::N2(u0, s1, u2)))
                    }
                    TTTreeRemoveResult::SC(u10) => {
                        //      s0    s1
                        //   u0    u1    u2
                        //         |
                        match *u0 {
                            TTTree_::N2(u00, s00, u01) => {
                                //      s0    s1
                                //   u0    u1    u2
                                //   /\    |
                                // u00 u01 u10
                                TTTreeRemoveResult::MC(Box::new(TTTree_::N2(
                                    Box::new(TTTree_::N3(u00, s00, u01, s0, u10)),
                                    s1,
                                    u2,
                                )))
                            }
                            TTTree_::N3(u00, s00, u01, s01, u02) => {
                                //      s0    s1
                                //   u0    u1    u2
                                //   /|\    |
                                // u00 u01 u02 u10
                                TTTreeRemoveResult::MC(Box::new(TTTree_::N3(
                                    Box::new(TTTree_::N2(u00, s00, u01)),
                                    s01,
                                    Box::new(TTTree_::N2(u02, s0, u10)),
                                    s1,
                                    u2,
                                )))
                            }
                            _ => panic!("assertion failed"),
                        }
                    }
                    TTTreeRemoveResult::MC(u1_) => {
                        TTTreeRemoveResult::MC(Box::new(TTTree_::N3(u0, s0, u1_, s1, u2)))
                    }
                }
            } else {
                match tttree_remove_(x, u2) {
                    TTTreeRemoveResult::E => {
                        TTTreeRemoveResult::MC(Box::new(TTTree_::N2(u0, s0, u1)))
                    }
                    TTTreeRemoveResult::SC(u20) => {
                        //      s0    s1
                        //   u0    u1    u2
                        //               |
                        //               u20
                        match *u1 {
                            TTTree_::N2(u10, s10, u11) => {
                                //      s0    s1
                                //   u0    u1     u2
                                //         /\     |
                                //       u10 u11  u20
                                TTTreeRemoveResult::MC(Box::new(TTTree_::N2(
                                    u0,
                                    s0,
                                    Box::new(TTTree_::N3(u10, s10, u11, s1, u20)),
                                )))
                            }
                            TTTree_::N3(u10, s10, u11, s11, u12) => {
                                //      s0     s1
                                //   u0     u1     u2
                                //         /|\     |
                                //       u10 u11 u12 u20
                                TTTreeRemoveResult::MC(Box::new(TTTree_::N3(
                                    u0,
                                    s0,
                                    Box::new(TTTree_::N2(u10, s10, u11)),
                                    s11,
                                    Box::new(TTTree_::N2(u12, s1, u20)),
                                )))
                            }
                            _ => panic!("assertion failed"),
                        }
                    }
                    TTTreeRemoveResult::MC(u2_) => {
                        TTTreeRemoveResult::MC(Box::new(TTTree_::N3(u0, s0, u1, s1, u2_)))
                    }
                }
            }
        }
    }
}

fn tttree_remove(x: i64, t: TTTree) -> TTTree {
    match t {
        TTTree::Empty => TTTree::Empty,
        TTTree::Singleton(y) => {
            if x == y {
                TTTree::Empty
            } else {
                TTTree::Singleton(y)
            }
        }
        TTTree::TTTree(t_) => match tttree_remove_(x, t_) {
            TTTreeRemoveResult::E => TTTree::Empty,
            TTTreeRemoveResult::SC(t__) => match *t__ {
                TTTree_::Leaf(x) => TTTree::Singleton(x),
                other => TTTree::TTTree(Box::new(other)),
            },
            TTTreeRemoveResult::MC(t__) => TTTree::TTTree(t__),
        },
    }
}

/** end hidden */
/** end my answer */

fn add_seq(xs: &[i64], t: TTTree) -> TTTree {
    let mut t = t;
    for x in xs {
        t = tttree_add(*x, t);
    }
    t
}

fn lookup_seq(xs: &[i64], t: &TTTree) -> bool {
    for x in xs {
        if !tttree_lookup(*x, t) {
            return false;
        }
    }
    true
}

fn remove_seq(xs: &[i64], t: TTTree) -> TTTree {
    let mut t = t;
    for x in xs {
        t = tttree_remove(*x, t);
    }
    t
}

fn range(n : i64) -> Vec<i64> {
    (0..n).collect()
}

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
make a tree by inserting elements in xs0;
check if all elements in xs1 are in the tree;
then remove all elements in xs1 from the tree
and check if we are left with empty tree */
fn check_seq(xs0: &[i64], xs1: &[i64]) -> bool {
    print_vec("insert in this order: ", xs0, 7);
    print_vec("remove in this order: ", xs1, 7);
    let t = add_seq(xs0, TTTree::Empty);
    let _ = tttree_check(&t);
    if lookup_seq(xs1, &t) {
        match remove_seq(xs1, t) {
	    TTTree::Empty => true,
	    _ => false,
	}
    } else {
        false
    }
}

fn check_random(insert_seed: i64, remove_seed: i64, n: i64) -> bool {
    let rng = range(n);
    let xs0 = random_shuffle(insert_seed, rng.clone());
    let xs1 = random_shuffle(remove_seed, rng);
    check_seq(&xs0, &xs1)
}

fn main() {
    let insert_seed: i64 = 1234;
    let remove_seed: i64 = 123456;
    assert!(check_random(insert_seed, remove_seed, 2));
    assert!(check_random(insert_seed, remove_seed, 3));
    assert!(check_random(insert_seed + 0, remove_seed + 0, 4));
    assert!(check_random(insert_seed + 1, remove_seed + 1, 4));
    assert!(check_random(insert_seed + 2, remove_seed + 2, 4));
    assert!(check_random(insert_seed + 3, remove_seed + 3, 4));
    assert!(check_random(insert_seed + 0, remove_seed + 0, 5));
    assert!(check_random(insert_seed + 1, remove_seed + 1, 5));
    assert!(check_random(insert_seed + 2, remove_seed + 2, 5));
    assert!(check_random(insert_seed + 3, remove_seed + 3, 5));
    assert!(check_random(insert_seed, remove_seed, 10));
    assert!(check_random(insert_seed, remove_seed, 100));
    assert!(check_random(insert_seed, remove_seed, 1000));
    assert!(check_random(insert_seed, remove_seed, 10000));
    assert!(check_random(insert_seed, remove_seed, 100000));
    println!("OK")
}
