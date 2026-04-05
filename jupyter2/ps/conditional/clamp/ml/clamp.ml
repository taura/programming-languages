(** begin my answer *)

(** begin hidden *)
let clamp x low high =
  if x < low then
    low
  else if x > high then
    high
  else
    x;;
(** end hidden *)
(** end my answer *)

let main () =
  assert (abs_float (clamp (-3.0) 0.0 10.0 -.  0.0) < 1.0e-5);
  assert (abs_float (clamp   4.0  0.0 10.0 -.  4.0) < 1.0e-5);
  assert (abs_float (clamp  15.0  0.0 10.0 -. 10.0) < 1.0e-5);
  Printf.printf "OK\n"
;;

main()
