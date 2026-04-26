(** begin my answer *)

(** end my answer *)

(* add all values in list xs to tree t in order *)
let rec add_seq xs t =
  match xs with
    [] -> t
  | x :: rs -> add_seq rs (binheap_add x t)
;;

(* remove all values from t and push them into xs *)
let rec binheap_to_seq_ t xs =
  match t with
    Empty -> xs
  | _ ->
     let x, t' = binheap_remove_min t in
     binheap_to_seq_ t' (x :: xs)
;;
let binheap_to_seq t =
  List.rev (binheap_to_seq_ t [])
;;

(* 0 ... n - 1 *)
let rec range_ i n xs =
  if i = n then
    xs
  else
    range_ (i + 1) n (i :: xs)
;;
let range n =
  List.rev (range_ 0 n [])
;;

(* random sequence *)
let rec random_seq_ i n x seq =
  if i = n then
    seq
  else
    let y = (0x5DEECE66D * x + 0xB) land 0xFFFFFFFFFFFF in
    random_seq_ (i + 1) n y ((y lsr 17) :: seq)
;;
let rec random_seq n seed =
  List.rev (random_seq_ 0 n seed [])
;;

(* randomly shuffle xs *)
let random_shuffle seed xs =
  (List.combine (random_seq (List.length xs) seed) xs)
  |> List.sort (fun (a, _) (b, _) -> compare a b)
  |> List.map snd    
;;

(* print int list *)
let rec print_elems xs i n =
  if i = n then
    Printf.printf " ..."
  else
    match xs with
      [] -> ()
    | x :: rs ->
       (if i > 0 then
          Printf.printf ", %d" x
        else
          Printf.printf "%d" x;
        print_elems rs (i + 1) n)
;;

let print_list header xs n =
  Printf.printf "%s[" header;
  print_elems xs 0 n;
  Printf.printf "]\n";
  flush stdout
;;

(* add xs to empty tree; remove all elements from the tree;
   check if they are sorted *)
let check_seq xs =
  print_list "input:  " xs 7;
  let t = add_seq xs Empty in
  let ys = binheap_to_seq t in
  print_list "output: " ys 7;
  ys = (List.sort (-) xs)
;;

(* randomly shuffle 0 .. n-1;
   add them to empty tree;
   remove all elements from the tree;
   check they are sorted *)
let check_random seed n =
  let rng = range n in
  let xs = random_shuffle seed rng in
  check_seq xs
;;

let main () =
  let seed = 12345 in
  assert(check_random seed 2);
  assert(check_random seed 3);
  assert(check_random seed 4);
  assert(check_random seed 5);
  assert(check_random seed 10);
  assert(check_random seed 100);
  assert(check_random seed 1000);
  assert(check_random seed 10000);
  assert(check_random seed 100000);
  Printf.printf "OK\n"
;;

main()
