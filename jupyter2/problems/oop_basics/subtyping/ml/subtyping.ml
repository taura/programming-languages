(** begin my answer *)

(** end my answer *)

let very_close x y =
  abs_float (x -. y) < 1e-6
;;

let main () =
  let e0 = mk_free_ellipse 16. 5. in
  let r0 = mk_free_rect    16. 5. in
  let e1 = mk_free_ellipse  6. 3. in
  let r1 = mk_free_rect     6. 3. in
  let d0 = mk_ellipse 16. 5. (-15.) (-4.) in
  let q0 = mk_rect    16. 5. (-15.) (-4.) in
  let d1 = mk_ellipse  6. 3. (-3.)  (-2.) in
  let q1 = mk_rect     6. 3. (-3.)  (-2.) in
  assert (very_close e0#area 251.327412);
  assert (very_close r0#area 80.);
  assert (very_close e1#area 56.548668);
  assert (very_close r1#area 18.);
  assert (very_close d0#area 251.327412);
  assert (very_close q0#area 80.);
  assert (very_close d1#area 56.548668);
  assert (very_close q1#area 18.);
  assert (smaller e0 e1 = 1);
  assert (smaller e0 r0 = 1);
  assert (smaller d1 q0 = 0);
  assert (smaller e0 d0 = 0);
  let s0 = mk_free_shapes () in
  let s1 = mk_shapes () in
  let s2 = mk_mixed_shapes () in
  (* un-comment lines below that pass static type checking *)
  (* assert (count_contains s0 0. 0. = 3); *)
  assert (count_contains s1 0. 0. = 3);
  (* assert (count_contains s2 0. 0. = 6); *)
  assert (very_close (sum_area s0) 405.876080);
  assert (very_close (sum_area s1) 405.876080);
  assert (very_close (sum_area s2) 811.752160);
  Printf.printf "OK\n"
;;

main()
