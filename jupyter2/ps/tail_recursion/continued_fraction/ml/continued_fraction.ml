(** begin my answer *)

(** begin hidden *)
let rec continued_fraction_tail_rec a m xm n =
  if m = n then
    xm
  else
    let xm_1 = 1.0 /. (a +. xm) in
    continued_fraction_tail_rec a (m + 1) xm_1 n

let rec continued_fraction_tail a n = continued_fraction_tail_rec a 0 1.0 n
(** end hidden *)
(** end my answer *)


let main () =
  assert (Float.abs (continued_fraction_tail 2.0 100 -. 0.4142136) < 1.0e-6);
  assert (Float.abs (continued_fraction_tail 3.0 100 -. 0.3027756) < 1.0e-6);
  assert (Float.abs (continued_fraction_tail 4.0 100 -. 0.2360680) < 1.0e-6);
  Printf.printf "OK\n"
;;

main()
