(** begin my answer *)

(** begin hidden *)
let rec continued_fraction a n =
  if n = 0 then
    1.0
  else
    1.0 /. (a +. continued_fraction a (n - 1))
(** end hidden *)
(** end my answer *)

let main () =
  assert (Float.abs (continued_fraction 2.0 100 -. 0.4142136) < 1.0e-6);
  assert (Float.abs (continued_fraction 3.0 100 -. 0.3027756) < 1.0e-6);
  assert (Float.abs (continued_fraction 4.0 100 -. 0.2360680) < 1.0e-6);
  Printf.printf "OK\n"
;;

main()
