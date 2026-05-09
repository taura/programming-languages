/** begin my answer */

fn count_paths(a: i64, b: i64) -> i64 {
    if a == 0 || b == 0 {
        1
    } else {
        count_paths(a - 1, b) + count_paths(a, b - 1)
    }
}

fn count_paths_below_rec(p : i64, q : i64, a : i64, b : i64) -> i64 {
    if p == 0 || q == 0 {
        1
    } else if -b * p + a * q > 0 {
        0
    } else {
        count_paths_below_rec(p - 1, q, a, b) + count_paths_below_rec(p, q - 1, a, b)
    }
}

fn count_paths_below(a : i64, b : i64) -> i64 {
    count_paths_below_rec(a, b, a, b)
}

/** end my answer */

fn main() {
    assert!(count_paths(7, 3)         == 120);
    assert!(count_paths_below(7, 3)   == 12);
    assert!(count_paths(12, 8)        == 125970);
    assert!(count_paths_below(12, 8)  == 7229);
    assert!(count_paths(17, 13)       == 119759850);
    assert!(count_paths_below(17, 13) == 3991995);
    println!("OK");
}
