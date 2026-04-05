(** begin my answer *)

(** end my answer *)

let main () =
  assert (abs_float (gaussian_integral  1.0 1000)  -. 1.493648 < 1.0e-6);
  assert (abs_float (gaussian_integral  2.0 2000)  -. 1.764163 < 1.0e-6);
  assert (abs_float (gaussian_integral 10.0 10000) -. Float.sqrt Float.pi < 1.0e-6);
  Printf.printf "OK\n"
;;

main()
