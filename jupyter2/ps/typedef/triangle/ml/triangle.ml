(** begin my answer *)

(** begin hidden *)
type vec2 = Vec2 of (float * float)

type triangle = Triangle of (vec2 * vec2 * vec2)

let vec2_minus (Vec2 (x1, y1)) (Vec2 (x2, y2)) =
  Vec2 (x1 -. x2, y1 -. y2)

let cross (Vec2 (x1, y1)) (Vec2 (x2, y2)) =
  x1 *. y2 -. y1 *. x2

let area_of_triangle (Triangle (p1, p2, p3)) =
  let v1 = vec2_minus p2 p1 in
  let v2 = vec2_minus p3 p1 in
  0.5 *. Float.abs (cross v1 v2)

(** end hidden *)
(** end my answer *)

let check x0 y0 x1 y1 x2 y2 a =
  let t = Triangle (Vec2 (x0, y0), Vec2 (x1, y1), Vec2 (x2, y2)) in
  Float.abs (area_of_triangle t -. a) < 1e-6
;;

let main () =
  assert (check 0.  0.  1.  0.  0.  1.   0.500);
  assert (check 9.9 0.3 3.2 5.1 6.1 0.2  9.455);
  assert (check 4.6 6.4 0.4 0.3 5.5 9.1  2.925);
  assert (check 5.2 5.5 9.9 0.0 3.1 4.0  9.300);
  assert (check 6.0 1.2 0.6 5.5 9.9 3.2 13.785);
  Printf.printf "OK\n"
;;

main()
