(** begin my answer *)

(** end my answer *)

let main () =
  assert (abs_float (triangle_area 0.0 0.0 1.0 0.0 0.0 1.0 -. 0.5) < 1.0e-5);
  assert (abs_float (triangle_area 0.0 0.0 2.0 0.0 0.0 2.0 -. 2.0) < 1.0e-5);
  assert (abs_float (triangle_area 1.0 1.0 4.0 1.0 1.0 5.0 -. 6.0) < 1.0e-5);
  Printf.printf "OK\n"
;;

main()
