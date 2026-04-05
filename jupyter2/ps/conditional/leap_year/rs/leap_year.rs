/** begin my answer */

/** begin hidden */
fn is_leap_year(year: i64) -> bool {
    if year % 400 == 0 {
        true
    } else if year % 100 == 0 {
        false
    } else if year % 4 == 0 {
        true
    } else {
        false
    }
}
/** end hidden */
/** end my answer */

fn main() {
    assert!( is_leap_year(2000) );
    assert!(!is_leap_year(1900));
    assert!( is_leap_year(2024) );
    assert!(!is_leap_year(2023));
    println!("OK")
}
