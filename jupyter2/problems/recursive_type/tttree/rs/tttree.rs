/** begin my answer */

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
