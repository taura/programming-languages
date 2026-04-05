(** begin my answer *)

(** begin hidden *)
let find_root a b eps =
  let f x = x *. x *. x -. x -. 2.0 in
  let l = ref a in
  let r = ref b in
  while abs_float (!r -. !l) > eps do
    let c = 0.5 *. (!l +. !r) in
    if f !l *. f c < 0.0 then
      r := c
    else
      l := c
  done;
  0.5 *. (!l +. !r);;
(** end hidden *)
(** end my answer *)

let main () =
  assert (abs_float (find_root 0.0 2.0 1.0e-20 -. 1.5213797) < 1.0e-6);
  Printf.printf "OK\n"
;;

main()
