
package pl06
func Collatz(n int64) int64 {
    if n % 2 == 0 {
        return n / 2
    } else {
        return 3 * n + 1
    }
}
