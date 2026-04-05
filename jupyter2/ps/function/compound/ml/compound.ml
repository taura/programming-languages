(** begin my answer *)

(** begin hidden *)
let compound p r t = p *. (1.0 +. r) ** t;;
(** end hidden *)
(** end my answer *)

let main () =
  assert (abs_float (compound 100.0 0.1  2.0 -. 121.0) < 1e-5);
  assert (abs_float (compound 100.0 0.2  5.0 -. 248.832) < 1e-5);
  assert (abs_float (compound 100.0 0.3 10.0 -. 1378.584918) < 1e-5);
  Printf.printf "OK\n"
;;

main()
