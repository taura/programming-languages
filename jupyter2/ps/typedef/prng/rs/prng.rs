/** begin my answer */

/** begin hidden */
struct Prng {
    x: u64,
}

fn mk_prng(seed: u64) -> Prng {
    Prng { x: seed }
}

fn nrand48(rg: &mut Prng) -> u64 {
    let y = (0x5DEECE66Du64.wrapping_mul(rg.x) + 0xB) & 0xFFFFFFFFFFFF;
    rg.x = y;
    y >> 17
}
/** end hidden */
/** end my answer */

fn main() {
    let mut rg = mk_prng(112233445566778899);
    assert!(nrand48(&mut rg) == 1781099660);
    assert!(nrand48(&mut rg) == 328479882);
    assert!(nrand48(&mut rg) == 1084899894);
    assert!(nrand48(&mut rg) == 1228799231);
    assert!(nrand48(&mut rg) == 2081468441);
    println!("OK")
}
