(** begin my answer *)

(** end my answer *)

let main () =
  assert (abs_float (similarity 1.0 2.0   2.0    4.0  -. 1.0) < 1e-5);
  assert (abs_float (similarity 1.0 2.0   3.0    5.0  -. 0.997054) < 1e-5);
  assert (abs_float (similarity 2.0 3.0   3.0  (-2.0) -. 0.0) < 1e-5);
  assert (abs_float (similarity 3.0 4.0 (-3.0) (-1.0) -. -0.82219) < 1e-5);
  Printf.printf "OK\n"
;;

main()
