(** begin my answer *)

(** end my answer *)

let main () =
  assert ((abs_float (min_value (-1.0) 1.0 1000) -. 0.903266) < 1.0e-6);
  assert ((abs_float (min_value   1.0  2.0 1000) -. 1.928766) < 1.0e-6);
  Printf.printf "OK\n"
;;

main()
