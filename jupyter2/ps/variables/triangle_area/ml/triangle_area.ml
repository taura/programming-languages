(** begin my answer *)

(** begin hidden *)
let triangle_area x1 y1 x2 y2 x3 y3 =
  let dx21 = x2 -. x1 in
  let dy21 = y2 -. y1 in
  let dx31 = x3 -. x1 in
  let dy31 = y3 -. y1 in
  0.5 *. abs_float (dx21 *. dy31 -. dx31 *. dy21);;
(** end hidden *)
(** end my answer *)

let main () =
  assert (abs_float (triangle_area 0.0 0.0 1.0 0.0 0.0 1.0 -. 0.5) < 1.0e-5);
  assert (abs_float (triangle_area 0.0 0.0 2.0 0.0 0.0 2.0 -. 2.0) < 1.0e-5);
  assert (abs_float (triangle_area 1.0 1.0 4.0 1.0 1.0 5.0 -. 6.0) < 1.0e-5);
  Printf.printf "OK\n"
;;

main()
