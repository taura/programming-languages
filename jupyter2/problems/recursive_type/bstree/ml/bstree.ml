(** begin my answer *)

(** end my answer *)

(* insert all elements in xs into t *)
let rec insert_seq xs t =
  match xs with
    [] -> t
  | x :: r ->
     let t = insert x t in
     insert_seq r t
;;

(* prepend n random numbers in front of seq *)
let rec random_seq n x seq =
  if n = 0 then
    List.rev seq
  else
    let y = (0x5DEECE66D * x + 0xB) land 0xFFFFFFFFFFFF in
    random_seq (n - 1) y ((y lsr 17) :: seq)
;;

let check_seq xs m =
  let t = insert_seq xs Empty in
  let sorted = List.sort (-) xs in
  (nth m t) = (List.nth sorted m)
;;

(* generate n random numbers, insert all of them, get m-th number from the tree.
   check if it is equal to a *)
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
