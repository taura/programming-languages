(** begin my answer *)

(** end my answer *)

let main () =
  assert (abs_float (find_root 0.0 2.0 1.0e-20 -. 1.5213797) < 1.0e-6);
  Printf.printf "OK\n"
;;

main()
