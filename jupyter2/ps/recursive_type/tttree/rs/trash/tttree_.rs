#![allow(non_camel_case_types)]
#![allow(dead_code)]

/** begin my answer */

/** begin hidden */

// non-empty two-three-tree
#[derive(PartialEq)]
enum TTTree_ {
    Leaf(i64),
    N2(Box<TTTree_>, i64, Box<TTTree_>),
    N3(Box<TTTree_>, i64, Box<TTTree_>, i64, Box<TTTree_>),
}

#[derive(PartialEq)]
enum TTTree {
    Empty,
    Singleton(i64),
    TTTree(Box<TTTree_>),
}

enum TTTreeAddResult {
    T(TTTree_),                    // ordinary result
    S(TTTree_, i64, TTTree_),      // split
}

enum TTTreeRemoveResult {
    E,                             // leaf -> empty
    SC(TTTree_),                   // single-child
    MC(TTTree_),                   // ordinary
}

fn tttree__check(t: &TTTree_) -> i64 {
    match t {
        TTTree_::Leaf(_) => 1,
        TTTree_::N2(u0, _, u1) => {
            let d0 = tttree__check(u0);
            let d1 = tttree__check(u1);
            assert!(d0 == d1);
            d0 + 1
        }
        TTTree_::N3(u0, _, u1, _, u2) => {
            let d0 = tttree__check(u0);
            let d1 = tttree__check(u1);
            let d2 = tttree__check(u2);
            assert!(d0 == d1 && d1 == d2);
            d0 + 1
        }
    }
}

fn tttree_check(t: &TTTree) -> i64 {
    match t {
        TTTree::Empty => 0,
        TTTree::Singleton(_) => 1,
        TTTree::TTTree(t_) => tttree__check(t_),
    }
}

fn tttree__add_rec(x: i64, t: TTTree_) -> TTTreeAddResult {
    match t {
        TTTree_::Leaf(y) => {
            let (u, v) = if x < y { (x, y) } else { (y, x) };
            TTTreeAddResult::S(TTTree_::Leaf(u), v, TTTree_::Leaf(v))
        }
        TTTree_::N2(u0, s0, u1) => {
            /*    s0
               u0    u1  */
            if x < s0 {
                match tttree__add_rec(x, *u0) {
                    TTTreeAddResult::S(u00, s00, u01) => {
                        /*    s00     s0
                          u00     u01    u1  */
                        TTTreeAddResult::T(TTTree_::N3(Box::new(u00), s00, Box::new(u01), s0, u1))
                    }
                    TTTreeAddResult::T(u0_) => TTTreeAddResult::T(TTTree_::N2(Box::new(u0_), s0, u1)),
                }
            } else {
                match tttree__add_rec(x, *u1) {
                    TTTreeAddResult::S(u10, s10, u11) => {
                        /*    s0     s10
                           u0    u10     u11  */
                        TTTreeAddResult::T(TTTree_::N3(u0, s0, Box::new(u10), s10, Box::new(u11)))
                    }
                    TTTreeAddResult::T(u1_) => TTTreeAddResult::T(TTTree_::N2(u0, s0, Box::new(u1_))),
                }
            }
        }
        TTTree_::N3(u0, s0, u1, s1, u2) => {
            /*    s0    s1
               u0    u1    u2 */
            if x < s0 {
                match tttree__add_rec(x, *u0) {
                    TTTreeAddResult::S(u00, s00, u01) => {
                        /*     s00     s0     s1
                           u00     u01     u1    u2 */
                        TTTreeAddResult::S(
                            TTTree_::N2(Box::new(u00), s00, Box::new(u01)),
                            s0,
                            TTTree_::N2(u1, s1, u2),
                        )
                    }
                    TTTreeAddResult::T(u0_) => {
                        TTTreeAddResult::T(TTTree_::N3(Box::new(u0_), s0, u1, s1, u2))
                    }
                }
            } else if x < s1 {
                match tttree__add_rec(x, *u1) {
                    /*    s0     s10      s1
                       u0    u10      u11    u2 */
                    TTTreeAddResult::S(u10, s10, u11) => TTTreeAddResult::S(
                        TTTree_::N2(u0, s0, Box::new(u10)),
                        s10,
                        TTTree_::N2(Box::new(u11), s1, u2),
                    ),
                    TTTreeAddResult::T(u1_) => {
                        TTTreeAddResult::T(TTTree_::N3(u0, s0, Box::new(u1_), s1, u2))
                    }
                }
            } else {
                match tttree__add_rec(x, *u2) {
                    TTTreeAddResult::S(u20, s20, u21) => {
                        /*    s0    s1     s21
                           u0    u1    u20     u21 */
                        TTTreeAddResult::S(
                            TTTree_::N2(u0, s0, u1),
                            s1,
                            TTTree_::N2(Box::new(u20), s20, Box::new(u21)),
                        )
                    }
                    TTTreeAddResult::T(u2_) => {
                        TTTreeAddResult::T(TTTree_::N3(u0, s0, u1, s1, Box::new(u2_)))
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
        TTTree::TTTree(t_) => match tttree__add_rec(x, *t_) {
            TTTreeAddResult::S(t0, s0, t1) => TTTree::TTTree(Box::new(TTTree_::N2(
                Box::new(t0),
                s0,
                Box::new(t1),
            ))),
            TTTreeAddResult::T(t__) => TTTree::TTTree(Box::new(t__)),
        },
    }
}

fn tttree__lookup(x: i64, t: &TTTree_) -> bool {
    match t {
        TTTree_::Leaf(y) => x == *y,
        TTTree_::N2(p, a, q) => {
            if x < *a { tttree__lookup(x, p) } else { tttree__lookup(x, q) }
        }
        TTTree_::N3(p, a, q, b, r) => {
            if x < *a { tttree__lookup(x, p) }
            else if x < *b { tttree__lookup(x, q) }
            else { tttree__lookup(x, r) }
        }
    }
}

fn tttree_lookup(x: i64, t: &TTTree) -> bool {
    match t {
        TTTree::Empty => false,
        TTTree::Singleton(y) => x == *y,
        TTTree::TTTree(t_) => tttree__lookup(x, t_),
    }
}

fn tttree__remove_rec(x: i64, t: TTTree_) -> TTTreeRemoveResult {
    match t {
        TTTree_::Leaf(y) => {
            if x == y { TTTreeRemoveResult::E } else { TTTreeRemoveResult::MC(TTTree_::Leaf(y)) }
        }
        TTTree_::N2(u0, s0, u1) => {
            if x < s0 {
                match tttree__remove_rec(x, *u0) {
                    TTTreeRemoveResult::E => TTTreeRemoveResult::SC(*u1),
                    TTTreeRemoveResult::SC(u00) => {
                        /*      s0
                             u0    u1
                             |
                            u00         */
                        match *u1 {
                            TTTree_::N2(u10, s10, u11) => {
                                /*       s0
                                     u0      u1
                                     |       /\
                                     u00   u10 u11 */
                                TTTreeRemoveResult::SC(TTTree_::N3(
                                    Box::new(u00), s0, u10, s10, u11,
                                ))
                            }
                            TTTree_::N3(u10, s10, u11, s11, u12) => {
                                /*       s0
                                     u0      u1
                                     |       /|\
                                    u00   u10u11u12 */
                                TTTreeRemoveResult::MC(TTTree_::N2(
                                    Box::new(TTTree_::N2(Box::new(u00), s0, u10)),
                                    s10,
                                    Box::new(TTTree_::N2(u11, s11, u12)),
                                ))
                            }
                            _ => panic!("assert false"),
                        }
                    }
                    TTTreeRemoveResult::MC(u0_) => {
                        TTTreeRemoveResult::MC(TTTree_::N2(Box::new(u0_), s0, u1))
                    }
                }
            } else {
                match tttree__remove_rec(x, *u1) {
                    TTTreeRemoveResult::E => TTTreeRemoveResult::SC(*u0),
                    TTTreeRemoveResult::SC(u10) => {
                        match *u0 {
                            TTTree_::N2(u00, s00, u01) => {
                                TTTreeRemoveResult::SC(TTTree_::N3(
                                    u00, s00, u01, s0, Box::new(u10),
                                ))
                            }
                            TTTree_::N3(u00, s00, u01, s01, u02) => {
                                TTTreeRemoveResult::MC(TTTree_::N2(
                                    Box::new(TTTree_::N2(u00, s00, u01)),
                                    s01,
                                    Box::new(TTTree_::N2(u02, s0, Box::new(u10))),
                                ))
                            }
                            _ => panic!("assert false"),
                        }
                    }
                    TTTreeRemoveResult::MC(u1_) => {
                        TTTreeRemoveResult::MC(TTTree_::N2(u0, s0, Box::new(u1_)))
                    }
                }
            }
        }
        TTTree_::N3(u0, s0, u1, s1, u2) => {
            /*    s0    s1
               u0    u1    u2 */
            if x < s0 {
                match tttree__remove_rec(x, *u0) {
                    TTTreeRemoveResult::E => TTTreeRemoveResult::MC(TTTree_::N2(u1, s1, u2)),
                    TTTreeRemoveResult::SC(u00) => {
                        match *u1 {
                            TTTree_::N2(u10, s10, u11) => {
                                /*         s0    s1
                                       u0     u1    u2
                                       |      /\
                                       u00  u10 u11 */
                                TTTreeRemoveResult::MC(TTTree_::N2(
                                    Box::new(TTTree_::N3(Box::new(u00), s0, u10, s10, u11)),
                                    s1,
                                    u2,
                                ))
                            }
                            TTTree_::N3(u10, s10, u11, s11, u12) => {
                                /*        s0       s1
                                       u0      u1      u2
                                        |     /|\
                                      u00  u10u11u12 */
                                TTTreeRemoveResult::MC(TTTree_::N3(
                                    Box::new(TTTree_::N2(Box::new(u00), s0, u10)),
                                    s10,
                                    Box::new(TTTree_::N2(u11, s11, u12)),
                                    s1,
                                    u2,
                                ))
                            }
                            _ => panic!("assert false"),
                        }
                    }
                    TTTreeRemoveResult::MC(u0_) => {
                        TTTreeRemoveResult::MC(TTTree_::N3(Box::new(u0_), s0, u1, s1, u2))
                    }
                }
            } else if x < s1 {
                match tttree__remove_rec(x, *u1) {
                    TTTreeRemoveResult::E => TTTreeRemoveResult::MC(TTTree_::N2(u0, s1, u2)),
                    TTTreeRemoveResult::SC(u10) => {
                        /*      s0    s1
                             u0    u1    u2
                                   |          */
                        match *u0 {
                            TTTree_::N2(u00, s00, u01) => {
                                /*      s0    s1
                                     u0    u1    u2
                                     /\    |
                                  u00 u01  u10                */
                                TTTreeRemoveResult::MC(TTTree_::N2(
                                    Box::new(TTTree_::N3(u00, s00, u01, s0, Box::new(u10))),
                                    s1,
                                    u2,
                                ))
                            }
                            TTTree_::N3(u00, s00, u01, s01, u02) => {
                                /*      s0    s1
                                     u0    u1    u2
                                     /|\    |
                                 u00u01u02 u10                */
                                TTTreeRemoveResult::MC(TTTree_::N3(
                                    Box::new(TTTree_::N2(u00, s00, u01)),
                                    s01,
                                    Box::new(TTTree_::N2(u02, s0, Box::new(u10))),
                                    s1,
                                    u2,
                                ))
                            }
                            _ => panic!("assert false"),
                        }
                    }
                    TTTreeRemoveResult::MC(u1_) => {
                        TTTreeRemoveResult::MC(TTTree_::N3(u0, s0, Box::new(u1_), s1, u2))
                    }
                }
            } else {
                match tttree__remove_rec(x, *u2) {
                    TTTreeRemoveResult::E => TTTreeRemoveResult::MC(TTTree_::N2(u0, s0, u1)),
                    TTTreeRemoveResult::SC(u20) => {
                        /*      s0    s1
                             u0    u1    u2
                                         |
                                         u20  */
                        match *u1 {
                            TTTree_::N2(u10, s10, u11) => {
                                /*      s0    s1
                                     u0    u1     u2
                                           /\     |
                                         u10 u11  u20  */
                                TTTreeRemoveResult::MC(TTTree_::N2(
                                    u0,
                                    s0,
                                    Box::new(TTTree_::N3(u10, s10, u11, s1, Box::new(u20))),
                                ))
                            }
                            TTTree_::N3(u10, s10, u11, s11, u12) => {
                                /*      s0     s1
                                     u0     u1     u2
                                           /|\     |
                                        u10u11u12  u20  */
                                TTTreeRemoveResult::MC(TTTree_::N3(
                                    u0,
                                    s0,
                                    Box::new(TTTree_::N2(u10, s10, u11)),
                                    s11,
                                    Box::new(TTTree_::N2(u12, s1, Box::new(u20))),
                                ))
                            }
                            _ => panic!("assert false"),
                        }
                    }
                    TTTreeRemoveResult::MC(u2_) => {
                        TTTreeRemoveResult::MC(TTTree_::N3(u0, s0, u1, s1, Box::new(u2_)))
                    }
                }
            }
        }
    }
}

fn tttree_remove(x: i64, t: TTTree) -> TTTree {
    match t {
        TTTree::Empty => TTTree::Empty,
        TTTree::Singleton(y) => if x == y { TTTree::Empty } else { TTTree::Singleton(y) },
        TTTree::TTTree(t_) => match tttree__remove_rec(x, *t_) {
            TTTreeRemoveResult::E => TTTree::Empty,
            TTTreeRemoveResult::SC(TTTree_::Leaf(x)) => TTTree::Singleton(x),
            TTTreeRemoveResult::SC(t__) => TTTree::TTTree(Box::new(t__)),
            TTTreeRemoveResult::MC(t__) => TTTree::TTTree(Box::new(t__)),
        },
    }
}

/** end hidden */
/** end my answer */

fn add_seq(xs: Vec<i64>, t: TTTree) -> TTTree {
    // let _ = tttree_check(&t);
    // Note: converted from tail recursion to loop (Rust has no TCO)
    let mut t = t;
    let mut rest: &[i64] = &xs;
    loop {
        match rest {
            [] => return t,
            [x, rs @ ..] => { t = tttree_add(*x, t); rest = rs; }
        }
    }
}

fn lookup_seq(xs: &[i64], t: &TTTree) -> bool {
    // Note: converted from tail recursion to loop (Rust has no TCO)
    let mut xs = xs;
    loop {
        match xs {
            [] => return true,
            [x, rs @ ..] => {
                if !tttree_lookup(*x, t) { return false; }
                xs = rs;
            }
        }
    }
}

fn remove_seq(xs: Vec<i64>, t: TTTree) -> TTTree {
    // let _ = tttree_check(&t);
    // Note: converted from tail recursion to loop (Rust has no TCO)
    let mut t = t;
    let mut rest: &[i64] = &xs;
    loop {
        match rest {
            [] => return t,
            [x, rs @ ..] => { t = tttree_remove(*x, t); rest = rs; }
        }
    }
}

fn range(n: i64, xs: Vec<i64>) -> Vec<i64> {
    // Note: converted from tail recursion to loop (Rust has no TCO)
    let mut n = n;
    let mut xs = xs;
    loop {
        if n == 0 {
            return xs;
        } else {
            xs.insert(0, n - 1);  // OCaml: (n - 1) :: xs
            n -= 1;
        }
    }
}

// print int list
fn print_elems(xs: &[i64], i: i64, n: i64) {
    if i == n {
        print!(" ...");
    } else {
        match xs {
            [] => (),
            [x, rs @ ..] => {
                if i > 0 {
                    print!(", {}", x);
                } else {
                    print!("{}", x);
                }
                print_elems(rs, i + 1, n);
            }
        }
    }
}

fn print_list(header: &str, xs: &[i64], n: i64) {
    print!("{}[", header);
    print_elems(xs, 0, n);
    println!("]");
    use std::io::Write;
    std::io::stdout().flush().unwrap();
}

fn random_seq_(i: i64, n: i64, x: i64, seq: Vec<i64>) -> Vec<i64> {
    // Note: converted from tail recursion to loop (Rust has no TCO)
    // Using push (append) instead of prepend; List.rev removed in random_seq accordingly
    let mut i = i;
    let mut x = x;
    let mut seq = seq;
    loop {
        if i == n {
            return seq;
        } else {
            let y = (0x5DEECE66D_i64.wrapping_mul(x).wrapping_add(0xB)) & 0xFFFFFFFFFFFF_i64;
            seq.push(y >> 17);  // OCaml: (y lsr 17) :: seq (prepend)
            i += 1;
            x = y;
        }
    }
}

fn random_seq(n: i64, seed: i64) -> Vec<i64> {
    // Note: List.rev omitted because random_seq_ uses push instead of prepend
    random_seq_(0, n, seed, vec![])
}

fn random_shuffle(seed: i64, xs: Vec<i64>) -> Vec<i64> {
    let rs = random_seq(xs.len() as i64, seed);
    let mut cs: Vec<(i64, i64)> = rs.into_iter().zip(xs.into_iter()).collect();
    cs.sort_by(|(a, _), (b, _)| a.cmp(b));
    cs.into_iter().map(|(_, x)| x).collect()
}

fn check_seq(xs0: Vec<i64>, xs1: Vec<i64>) -> bool {
    print_list("insert in this order: ", &xs0, 7);
    print_list("remove in this order: ", &xs1, 7);
    let t = add_seq(xs0, TTTree::Empty);
    let _ = tttree_check(&t);
    if lookup_seq(&xs1, &t) {
        let e = remove_seq(xs1, t);
        e == TTTree::Empty
    } else {
        false
    }
}

fn check_random(insert_seed: i64, remove_seed: i64, n: i64) -> bool {
    let rng = range(n, vec![]);
    let xs0 = random_shuffle(insert_seed, rng.clone());
    let xs1 = random_shuffle(remove_seed, rng);
    check_seq(xs0, xs1)
}

fn main() {
    let insert_seed = 1234;
    let remove_seed = 123456;
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
