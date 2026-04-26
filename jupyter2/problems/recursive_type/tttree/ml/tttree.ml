(** begin my answer *)

(** end my answer *)

let rec add_seq xs t =
  (* let _ = tttree_check t in *)
  match xs with
    [] -> t
  | x :: rs -> add_seq rs (tttree_add x t)
;;

let rec lookup_seq xs t =
  match xs with
    [] -> true
  | x :: rs -> (tttree_lookup x t) && (lookup_seq rs t)
;;

let rec remove_seq xs t =
  (* let _ = tttree_check t in *)
  match xs with
    [] -> t
  | x :: rs -> remove_seq rs (tttree_remove x t)
;;

let rec range n xs =
  if n = 0 then
    xs
  else
    range (n - 1) ((n - 1) :: xs)

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

let random_shuffle seed xs =
  let rs = random_seq (List.length xs) seed in
  let cs = List.combine rs xs in
  let sorted_cs = List.sort (fun (a, _) (b, _) -> (-) a b) cs in
  let shuffled = List.map snd sorted_cs in
  shuffled
;;

let check_seq xs0 xs1 =
  print_list "insert in this order: " xs0 7;
  print_list "remove in this order: " xs1 7;
  let t = add_seq xs0 Empty in
  let _ = tttree_check t in
  if lookup_seq xs1 t then 
    let e = remove_seq xs1 t in
    e = Empty
  else
    false
;;

let check_random insert_seed remove_seed n =
  let rng = range n [] in
  let xs0 = random_shuffle insert_seed rng in
  let xs1 = random_shuffle remove_seed rng in
  check_seq xs0 xs1
;;

let main () =
  let insert_seed = 1234 in
  let remove_seed = 123456 in
  assert(check_random insert_seed remove_seed 2);
  assert(check_random insert_seed remove_seed 3);
  assert(check_random (insert_seed + 0) (remove_seed + 0) 4);
  assert(check_random (insert_seed + 1) (remove_seed + 1) 4);
  assert(check_random (insert_seed + 2) (remove_seed + 2) 4);
  assert(check_random (insert_seed + 3) (remove_seed + 3) 4);
  assert(check_random (insert_seed + 0) (remove_seed + 0) 5);
  assert(check_random (insert_seed + 1) (remove_seed + 1) 5);
  assert(check_random (insert_seed + 2) (remove_seed + 2) 5);
  assert(check_random (insert_seed + 3) (remove_seed + 3) 5);
  assert(check_random insert_seed remove_seed 10);
  assert(check_random insert_seed remove_seed 100);
  assert(check_random insert_seed remove_seed 1000);
  assert(check_random insert_seed remove_seed 10000);
  assert(check_random insert_seed remove_seed 100000);
  Printf.printf "OK\n"
;;

main()
