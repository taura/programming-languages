(** begin my answer *)

(** begin hidden *)
let gaussian_integral a n =
  let dx = 2.0 *. a /. float_of_int n in
  let s = ref 0.0 in
  for i = 0 to n - 1 do
    let x = -. a +. float_of_int i *. dx in
    s := !s +. exp (-. x *. x) *. dx
  done;
  !s;;
(** end hidden *)
(** end my answer *)

let main () =
  assert (abs_float (gaussian_integral  1.0 1000)  -. 1.493648 < 1.0e-6);
  assert (abs_float (gaussian_integral  2.0 2000)  -. 1.764163 < 1.0e-6);
  assert (abs_float (gaussian_integral 10.0 10000) -. Float.sqrt Float.pi < 1.0e-6);
  Printf.printf "OK\n"
;;

main()
