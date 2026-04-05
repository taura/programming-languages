(** begin my answer *)

(** end my answer *)

let main () =
  assert (abs_float (point_line_distance (-3.0) 1.0 1.0 (-2.0) 4.0 (-3.0) -. 1.0) < 1.0e-5);
  assert (abs_float (point_line_distance   2.0  2.0 4.0   0.0  1.0   0.0  -. 2.12132) < 1.0e-5);
  assert (abs_float (point_line_distance   1.0  1.0 4.0   3.0  3.0 (-2.0) -. 3.60555) < 1.0e-5);
  Printf.printf "OK\n"
;;

main()
