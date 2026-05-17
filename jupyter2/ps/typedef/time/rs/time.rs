/** begin my answer */

/** begin hidden */
struct Time {
	hour: u8,
	minute: u8,
	second: f64,
}

fn second_of_time(t: Time) -> f64 {
	3600.0 * (t.hour as f64) + 60.0 * (t.minute as f64) + t.second
}

fn time_diff(a : Time, b : Time) -> f64 {
    second_of_time(a) - second_of_time(b)
}
/** end hidden */
/** end my answer */

fn main() {
    assert!((time_diff(Time {hour: 12, minute: 0, second: 0.0}, Time {hour: 11, minute: 30, second: 0.0}) - 1800.0).abs() < 1e-6);
    assert!((time_diff(Time {hour: 23, minute: 59, second: 59.9}, Time {hour: 0, minute: 0, second: 0.0}) - 86399.9).abs() < 1e-6);
    println!("OK")
}
