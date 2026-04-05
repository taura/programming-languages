(** begin my answer *)

(** begin hidden *)
let point_line_distance x0 y0 x1 y1 p q =
  let dx = x1 -. x0 in
  let dy = y1 -. y0 in
  let a = dy in
  let b = -. dx in
  let num = abs_float (a *. (p -. x0) +. b *. (q -. y0)) in
  let den = sqrt (a *. a +. b *. b) in
  num /. den;;
(** end hidden *)
(** end my answer *)

let main () =
  assert (abs_float (point_line_distance (-3.0) 1.0 1.0 (-2.0) 4.0 (-3.0) -. 1.0) < 1.0e-5);
  assert (abs_float (point_line_distance   2.0  2.0 4.0   0.0  1.0   0.0  -. 2.12132) < 1.0e-5);
  assert (abs_float (point_line_distance   1.0  1.0 4.0   3.0  3.0 (-2.0) -. 3.60555) < 1.0e-5);
  Printf.printf "OK\n"
;;

main()
