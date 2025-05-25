(** if label == "add123"  *)
let add123 n = n + 123
;;
(** endif *)
(** if label == "many_args" *)
let many_args  a00 a01 a02 a03 a04 a05 a06 a07 a08 a09 a10 a11 =
  a00 + a01 + a02 + a03 + a04 + a05 + a06 + a07 + a08 + a09 + a10 + a11
;;
(** endif *)
(** if label == "add_floats" *)
let add_floats x y = x +. y
(** endif *)
(** if label == "get_float_array_elem" *)
let get_float_array_elem_const a = a.(2)
;;
let get_float_array_elem_i a i = a.(i)
(** endif *)
(** if label == "get_struct_elem" *)
type point_t = Point of float * float
;;
let get_point_y (Point(x, y)) = y
;;
(** endif *)
(** if label == "collatz" *)
let collatz n =
  if n mod 2 = 0 then
    n / 2
  else
    3 * n + 1
;;
(** endif *)
(** if label == "call_tanh" *)
let call_tanh x =
(Float.tanh (x +. 1.0)) +. 2.0
(** endif *)
(** if label == "regions" *)
let rec regions n = 
  if n = 0 then
    1
  else
    (regions (n - 1)) + n - 1
;;
(** endif *)
(** if label == "sum_array_rec" *)
let rec sum_array_rec a p q = 
  if q - p = 0 then
    0.0
  else if q - p = 1 then
    a.(p)
  else 
    let r = (p + q) / 2 in
    (sum_array_rec a p r) +. (sum_array_rec a r q)
;;
(** endif *)
(** if label == "regions_tail" *)
let rec regions_tail i n ri = 
  if i = n then
    ri
  else 
    let riplus1 = ri + i + 1 in
    regions_tail (i + 1) n riplus1
;;
(** endif *)
(** if label == "sum_array_tail_rec" *)
let rec sum_array_tail_rec a i n s = 
  if i = n then
    s
  else 
    sum_array_tail_rec a (i + 1) n (s + a.(i))
;;
(** endif *)
(** if label == "sum_array_loop" *)
let rec sum_array_loop a =
  let s = ref 0.0 in
  for i = 0 to Array.length a do
    s := !s +. a.(i)
  done;
  s
;;
(** endif *)
