/** begin my answer */

/** end my answer */

fn main() {
    assert!((time_diff(Time {hour: 12, minute: 0, second: 0.0}, Time {hour: 11, minute: 30, second: 0.0}) - 1800.0).abs() < 1e-6);
    assert!((time_diff(Time {hour: 23, minute: 59, second: 59.9}, Time {hour: 0, minute: 0, second: 0.0}) - 86399.9).abs() < 1e-6);
    println!("OK")
}
