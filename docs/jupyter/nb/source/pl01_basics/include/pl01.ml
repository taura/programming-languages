(** if label == "A function"  *)
let f x = x + 1
;;
(** endif *)
(** if label == "Apply a function"  *)
f 3
;;
(** endif *)
(** if label == "A recursive function"  *)
let rec fib n =
  if n < 2 then
    1
  else
    fib (n - 1) + fib (n - 2)
;;
(** endif *)
(** if label == "A variable"  *)
let rec fib2 n =
  if n < 2 then
    1
  else
    let x = fib2 (n - 1) in
    let y = fib2 (n - 2) in
    x + y
;;
(** endif *)
(** if label == "A data type"  *)
type person =
  Person of (string * string)
;;
(** endif *)
(** if label == "Person name"  *)
let person_name p =
  match p with
    Person(name, dob) -> name
;;
person_name (Person("Masakazu Mimura", "1967/6/8"))
;;
(** endif *)
(** if label == "bintree"  *)
type bintree =
  Empty
| Node of (bintree * bintree)
;;
(** endif *)
(** if label == "mk_tree"  *)
let rec mk_tree n = 
  if n = 0 then
    Empty
  else
    let rc = (n - 1) / 2 in
    let lc = n - 1 - rc in
    Node(mk_tree lc, mk_tree rc)
;;
(** endif *)
(** if label == "count_nodes"  *)
let rec count_nodes t =
  match t with 
    Empty -> 0
  | Node(l, r) -> 1 + count_nodes l + count_nodes r
;;
(** endif *)
(** if label == "1000 nodes"  *)
count_nodes (mk_tree 1000)
;;
(** endif *)
