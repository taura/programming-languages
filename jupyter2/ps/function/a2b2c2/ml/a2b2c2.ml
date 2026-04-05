(** begin my answer *)

(** begin hidden *)
let f a b c = a *. a +. b *. b -. c *. c;;
(** end hidden *)
(** end my answer *)

let main () =
  assert (abs_float (f 1.0 2.0 3.0 -. -4.0) < 1.0e-5);
  assert (abs_float (f 3.0 4.0 5.0 -.  0.0) < 1.0e-5);
  assert (abs_float (f 5.0 6.0 7.0 -. 12.0) < 1.0e-5);
  Printf.printf "OK\n"
;;

main()
