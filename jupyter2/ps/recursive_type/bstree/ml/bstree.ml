(** begin my answer *)

(** begin hidden *)
(* binary search tree whose nodes have, in addition to values and children,
   the number of nodes in each child *)
type bstree = Empty | Node of (int * int * bstree * int * bstree);;

let rec insert x t =
  match t with
    Empty -> Node (x, 0, Empty, 0, Empty)
  | Node (y, lc, l, rc, r) ->
     if x < y then
       Node (y, lc + 1, insert x l, rc, r)
     else
       Node (y, lc, l, rc + 1, insert x r)
;;

let rec nth n t =
  match t with
    Empty -> -1
  | Node (x, lc, l, rc, r) ->
     if n < lc then
       nth n l
     else if n = lc then
       x
     else
       nth (n - lc - 1) r
;;
(** end hidden *)
(** end my answer *)

(* test code below *)

(* insert all numbers in xs into t, and return the resulting tree *)
let rec insert_seq xs t =
  match xs with
    [] -> t
  | x :: r ->
     let t = insert x t in
     insert_seq r t
;;

(* prepend n random numbers before seq and reverse it *)
let rec random_seq n x seq =
  if n = 0 then
    List.rev seq
  else
    let y = (0x5DEECE66D * x + 0xB) land 0xFFFFFFFFFFFF in
    random_seq (n - 1) y ((y lsr 17) :: seq)
;;

(* insert all numbers in xs to an empty tree, and check that the m-th smallest number is correct *)
let check_seq xs m =
  let t = insert_seq xs Empty in
  let sorted = List.sort (-) xs in
  (nth m t) = (List.nth sorted m)
;;

(* generate a sequence of n random numbers with seed, insert them to an empty tree,
   and check that the m-th smallest number is correct *)
let check_random seed n m =
  let xs = random_seq n seed [] in
  check_seq xs m
;;

let main () =
  assert(check_seq [1;2;4;0;3] 2);
  assert(check_random 123      10      3);
  assert(check_random 123     100     40);
  assert(check_random 123    1000    500);
  assert(check_random 123   10000   6000);
  assert(check_random 123  100000  70000);

  assert(check_random 123 1000000 800000);
  Printf.printf "OK\n"
;;

main()
