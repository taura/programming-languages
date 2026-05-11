/** begin my answer */

/** end my answer */

/* test code below */

// insert all numbers in xs into t, and return the resulting tree
fn insert_seq(xs : Vec<u64>, t : BSTree) -> BSTree {
    let mut t = t;
    for x in xs {
	t = insert(x, t);
    }
    t
}

// generate a sequence of n random numbers with seed
fn random_seq(n : i64, seed: u64) -> Vec<u64> {
    let mut x = seed;
    let mut xs = Vec::new();
    for _ in 0..n {
	x = (0x5DEECE66Du64.wrapping_mul(x) + 0xB) & 0xFFFFFFFFFFFF;
	xs.push(x >> 17);
    }
    xs
}

// insert all numbers in xs to an empty tree, and check that the m-th smallest number is correct
fn check_seq(xs : Vec<u64>, m : i64) -> bool {
    let mut sorted = xs.clone();
    sorted.sort();
    let t = insert_seq(xs, BSTree::Empty);
    nth(m, t) == sorted[m as usize] as i64
}

// generate a sequence of n random numbers with seed, insert them to an empty tree,
// and check that the m-th smallest number is correct
fn check_random(seed: u64, n: i64, m: i64) -> bool {
    let xs = random_seq(n, seed);
    check_seq(xs, m)
}

fn main() {
    assert!(check_seq(vec![1,2,4,0,3], 2));
    assert!(check_random(123,      10,      3));
    assert!(check_random(123,     100,     40));
    assert!(check_random(123,    1000,    500));
    assert!(check_random(123,   10000,   6000));
    assert!(check_random(123,  100000,  70000));
    assert!(check_random(123, 1000000, 800000));
    println!("OK")
}
