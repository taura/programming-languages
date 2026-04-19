(** begin my answer *)

(** end my answer *)

let main () =
  assert (Float.abs (affine_recurrence_fast_tail   0.9999 1.0 2.0 100000  -. 9999.5463184) < 1.0e-6);
  assert (Float.abs (affine_recurrence_simple_tail 0.9999 1.0 2.0 100000  -. 9999.5463184) < 1.0e-6);
  assert (Float.abs (affine_recurrence_fast_tail   0.9999 1.0 2.0 1000000 -. 10000.0) < 1.0e-6);
  assert (Float.abs (affine_recurrence_simple_tail 0.9999 1.0 2.0 1000000 -. 10000.0) < 1.0e-6);
  Printf.printf "OK\n"
;;

main()
