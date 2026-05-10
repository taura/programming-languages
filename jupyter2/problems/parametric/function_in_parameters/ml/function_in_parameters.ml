(** begin my answer *)

(** end my answer *)

let main () =
  assert (app1 f = 1.0);
  assert (app1 g = [1.0]);
  assert (app  f 4 = 4);
  assert (app  h ["bye"] = Some "bye");
  Printf.printf "OK\n"
;;

main()
