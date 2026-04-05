(** begin my answer *)

(** end my answer *)

let main () =
  assert (abs_float (clamp (-3.0) 0.0 10.0 -.  0.0) < 1.0e-5);
  assert (abs_float (clamp   4.0  0.0 10.0 -.  4.0) < 1.0e-5);
  assert (abs_float (clamp  15.0  0.0 10.0 -. 10.0) < 1.0e-5);
  Printf.printf "OK\n"
;;

main()
