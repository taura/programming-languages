(** begin my answer *)

(** begin hidden *)
let gaussian_density mu sigma x =
  let z = (x -. mu) /. sigma in
  let z2 = z *. z in
  let norm = 1.0 /. (sqrt (2.0 *. Float.pi) *. sigma) in
  norm *. exp (-0.5 *. z2);;
(** end hidden *)
(** end my answer *)

let main () =
  assert (abs_float (gaussian_density 0.0 1.0 0.0 -. 0.398942) < 1.0e-5);
  assert (abs_float (gaussian_density 0.0 2.0 1.0 -. 0.176033) < 1.0e-5);
  assert (abs_float (gaussian_density 1.0 3.0 5.0 -. 0.054670) < 1.0e-5);
  Printf.printf "OK\n"
;;

main()
