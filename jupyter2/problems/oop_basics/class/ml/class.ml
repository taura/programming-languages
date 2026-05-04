(** begin my answer *)

(** end my answer *)

let very_close x y =
  abs_float (x -. y) < 1e-6
;;

let main () =
  let e0 = mk_free_ellipse 16. 5. in
  let e1 = mk_free_ellipse  6. 3. in
  assert (very_close e0#area 251.327412);
  assert (very_close e1#area 56.548668);
  assert (smaller e0 e1 = 1);
  Printf.printf "OK\n"
;;

main()
