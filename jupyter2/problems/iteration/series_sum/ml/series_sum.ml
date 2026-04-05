(** begin my answer *)

(** end my answer *)

let main () =
  let a = Float.pi *. Float.pi /. 6.0 in
  (assert (abs_float (series_sum 10 -. 1.549768) < 1.0e-5);
   assert (abs_float (series_sum 100000 -. a) < 1.0e-5);
   assert (abs_float (series_sum 1000000 -. a) < 1.0e-6);
   assert (abs_float (series_sum 20000000 -. a) < 1.0e-6));
  Printf.printf "OK\n"
;;

main()
