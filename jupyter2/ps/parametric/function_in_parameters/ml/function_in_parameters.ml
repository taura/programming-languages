(** begin my answer *)

(** begin hidden *)
let f x  = x

let g x = [x]

let h a =
  match a with
  | [] -> None
  | x::_ -> Some x

let app1 g = g 1.0

let app f x = f x

(** end hidden *)
(** end my answer *)

let main () =
  assert (app1 f = 1.0);
  assert (app1 g = [1.0]);
  assert (app  f 4 = 4);
  assert (app  h ["bye"] = Some "bye");
  Printf.printf "OK\n"
;;

main()
