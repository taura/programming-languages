(** begin my answer *)

(** begin hidden *)
type prng = Prng of (int ref);;

let mk_prng seed =
  Prng(ref seed)
;;

let nrand48 (Prng(x))  =
  let y = (0x5DEECE66D * !x + 0xB) land 0xFFFFFFFFFFFF in
  let _ = x := y in
  y lsr 17
;;
(** end hidden *)
(** end my answer *)

let main () =
  let rg = mk_prng 112233445566778899
  in
  assert (nrand48 rg = 1781099660);
  assert (nrand48 rg = 328479882);
  assert (nrand48 rg = 1084899894);
  assert (nrand48 rg = 1228799231);
  assert (nrand48 rg = 2081468441);
  Printf.printf "OK\n"
;;

main()
