(** begin my answer *)

(** end my answer *)

let main () =
  assert (abs_float (sigmoid (-5.0) -. 0.00669) < 1e-5);
  assert (abs_float (sigmoid (-0.5) -. 0.37754) < 1e-5);
  assert (abs_float (sigmoid   0.0  -. 0.5) < 1e-5);
  assert (abs_float (sigmoid  10.0  -. 0.999954) < 1e-5);
  Printf.printf "OK\n"
;;

main()
