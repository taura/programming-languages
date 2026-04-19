(** begin my answer *)

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
