(** begin my answer *)

(** begin hidden *)
let min_value a b n =
  let f x = x *. x *. x *. x -. 3.0 *. x *. x *. x +. 2.0 *. x *. x +. x +. 1.0 in
  let best = ref (f a) in
  for i = 1 to n do
    let x = a +. (b -. a) *. float_of_int i /. float_of_int n in
    let v = f x in
    if v < !best then best := v
  done;
  !best;;
(** end hidden *)
(** end my answer *)

let main () =
  assert ((abs_float (min_value (-1.0) 1.0 1000) -. 0.903266) < 1.0e-6);
  assert ((abs_float (min_value   1.0  2.0 1000) -. 1.928766) < 1.0e-6);
  Printf.printf "OK\n"
;;

main()
