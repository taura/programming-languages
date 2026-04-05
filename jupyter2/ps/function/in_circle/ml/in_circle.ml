(** begin my answer *)

(** begin hidden *)
let in_circle x y r = x *. x +. y *. y <= r *. r;;
(** end hidden *)
(** end my answer *)

let main () =
  assert (in_circle 1.0 1.0 2.0);
  assert (in_circle 3.0 4.0 6.0);
  assert (not (in_circle 3.0 0.0 2.0));
  Printf.printf "OK\n"
;;

main()
