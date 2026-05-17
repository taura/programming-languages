(** begin my answer *)

(** begin hidden *)
class free_ellipse a b =
  object
    method area = Float.pi *. a *. b
  end
;;

let mk_free_ellipse a b =
  new free_ellipse a b
;;

class ellipse a b x0 y0 =
  object
    inherit free_ellipse a b
    method contains x y =
      let dx = x -. x0 in
      let dy = y -. y0 in
      (dx *. dx) /. (a *. a) +. (dy *. dy) /. (b *. b) <= 1.0
  end
;;

let mk_ellipse a b x0 y0 =
  new ellipse a b x0 y0
;;

class free_rect w h =
  object
    method area = w *. h
  end
;;

let mk_free_rect w h =
  new free_rect w h
;;

class rect w h x0 y0 =
  object
    inherit free_rect w h
    method contains x y =
      x >= x0 && x <= x0 +. w && y >= y0 && y <= y0 +. h
  end
;;

let mk_rect w h x0 y0 =
  new rect w h x0 y0
;;

type free_shape = < area : float >
;;

let smaller s0 s1 = 
  if s0#area <= s1#area then 0 else 1
;;

let small s0 =
  s0#area <= 1.0
;;

let mk_free_shapes () =
  [
    mk_free_ellipse 16. 5. ;
    mk_free_rect    16. 5. ;
    mk_free_ellipse  6. 3. ;
    mk_free_rect     6. 3.
  ]
;;

let mk_shapes () =
  [
    mk_ellipse 16. 5. (-15.) (-4.) ;
    mk_rect    16. 5. (-15.) (-4.) ;
    mk_ellipse  6. 3. (-3.)  (-2.) ;
    mk_rect     6. 3. (-3.)  (-2.)
  ]
;;

let mk_mixed_shapes () =
  [
    mk_free_ellipse 16. 5. ;
    mk_free_rect    16. 5. ;
    mk_free_ellipse  6. 3. ;
    mk_free_rect     6. 3. ;
    (mk_ellipse 16. 5. (-15.) (-4.) :> free_shape) ;
    (mk_rect    16. 5. (-15.) (-4.) :> free_shape) ;
    (mk_ellipse  6. 3. (-3.)  (-2.) :> free_shape) ;
    (mk_rect     6. 3. (-3.)  (-2.) :> free_shape)
  ]
;;

let rec sum_area seq =
  match seq with
    [] -> 0.
  | s :: r -> s#area +. sum_area r
;;

let rec count_contains seq x y =
  match seq with
  | [] -> 0
  | s :: r ->
     if s#contains x y then
       count_contains r x y + 1
     else
       count_contains r x y
;;

(** end hidden *)
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
