(** begin my answer *)

(** begin hidden *)
type time = Time of (int * int * float);;

let second_of_time (Time (h, m, s)) =
  let h = float_of_int h in
  let m = float_of_int m in
  3600. *. h +. m *. 60. +. s
;;

let time_diff a b =
  let ta = second_of_time a in
  let tb = second_of_time b in
  ta -. tb
;;

(** end hidden *)
(** end my answer *)

let main () =
  assert (Float.abs (time_diff (Time(12, 0, 0.)) (Time(11, 30, 0.)) -. 1800.) < 1e-6);
  assert (Float.abs (time_diff (Time(23, 59, 59.9)) (Time(0, 0, 0.)) -. 86399.9) < 1e-6);
  Printf.printf "OK\n"
;;

main()
