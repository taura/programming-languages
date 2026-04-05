(** begin my answer *)

(** begin hidden *)
let height h0 v0 t = h0 +. v0 *. t -. 0.5 *. 9.8 *. t *. t;;
(** end hidden *)
(** end my answer *)

let main () =
  assert (abs_float (height 10.0  1.0   1.0 -.   6.1) < 1e-5);
  assert (abs_float (height 20.0  0.0   2.0 -.   0.4) < 1e-5);
  assert (abs_float (height 30.0 (-1.0) 3.0 -. -17.1) < 1e-5);
  Printf.printf "OK\n"
;;

main()
