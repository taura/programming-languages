(* (1) *)

let add_nums x y = x + y + 123
;;

let add_ints x y = x + y + 123
;;

let add_floats x y = x +. y +. 123.0
;;

(* (2) *)

type point = Point of float * float
;;

let get_point_y (Point(x, y)) = y
;;

(* (3) *)

let get_float_array_elem_const a = a.(2)
;;

let get_float_array_elem_var a i = a.(i)
;;

(* (4) *)

let collatz n =
  if n mod 2 = 0 then
    n / 2
  else
    3 * n + 1
;;

let gcd1 a b =
  if b = 0 then
    a
  else
    a mod b
;;

(* (5) *)

let sum_array_loop a n =
  let s = ref 0.0 in
  for i = 0 to n do
    s := !s +. a.(i)
  done;
  !s
;;

(* (6) *)

let call_tanh x =
  (Float.tanh (x +. 1.0)) +. x
;;

(* (7) *)

let rec sum_array_rec a n =
  if n = 0 then
    0.0
  else
    (sum_array_rec a (n - 1)) +. a.(n - 1)
;;

(* (8) *)

let rec sum_array_tail a i n s =
  if i = n then
    s
  else
    sum_array_tail a (i + 1) n (s +. a.(i))
;;

(* (9) *)

let mk_point x y =
  Point(x +. 1.0, y +. 2.0)
;;

(* (10) *)

let mk_vector x =
  [|x; x; x; x; x; x; x; x; x; x|]
;;

(* (11) *)

let call_area s = s#area
;;
