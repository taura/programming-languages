/** begin my answer */

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
