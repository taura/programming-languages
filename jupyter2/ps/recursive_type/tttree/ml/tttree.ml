(** begin my answer *)

(** begin hidden *)

(* non-empty two-three-tree *)
type tttree_ =
  Leaf of int
| N2 of (tttree_ * int * tttree_)
| N3 of (tttree_ * int * tttree_ * int * tttree_)
;;

type tttree =
  Empty
| Singleton of int
| TTTree of tttree_
;;

type tttree_add_result =
  | T of tttree_                (* ordinary result *)
  | S of (tttree_ * int * tttree_) (* split *)
;;

type tttree_remove_result =
  | E                           (* leaf -> empty *)
  | SC of tttree_                (* single-child *)
  | MC of tttree_                (* ordinary *)
;;

let rec tttree__check t = 
  match t with
  | Leaf _ -> 0
  | N2 (u0, _, u1) ->
     let d0 = tttree__check u0 in
     let d1 = tttree__check u1 in
     assert(d0 = d1);
     d0 + 1
  | N3 (u0, _, u1, _, u2) ->
     let d0 = tttree__check u0 in
     let d1 = tttree__check u1 in
     let d2 = tttree__check u2 in
     assert(d0 = d1 && d1 = d2);
     d0 + 1
;;

let tttree_check t =
  match t with
  | Empty -> 0
  | Singleton _ -> 1
  | TTTree t' -> tttree__check t'
;;

let rec tttree__add_rec x t =
  match t with
  | Leaf y ->
     let u, v = if x < y then (x, y) else (y, x) in
     S(Leaf u, v, Leaf v)
  | N2 (u0, s0, u1) ->
     (*    s0
        u0    u1  *)
     (if x < s0 then
        match tttree__add_rec x u0 with
        | S(u00, s00, u01) ->
           (*    s00     s0
             u00     u01    u1  *)
           T(N3(u00, s00, u01, s0, u1))
        | T(u0') -> T(N2(u0', s0, u1))
      else
        match tttree__add_rec x u1 with
        | S(u10, s10, u11) ->
           (*    s0     s10
              u0    u10     u11  *)
           T(N3(u0, s0, u10, s10, u11))
        | T(u1') -> T(N2(u0, s0, u1')))
  | N3 (u0, s0, u1, s1, u2) ->
     (*    s0    s1
        u0    u1    u2 *)
     (if x < s0 then
        match tttree__add_rec x u0 with
        | S(u00, s00, u01) ->
           (*     s00     s0     s1
              u00     u01     u1    u2 *)
           S(N2(u00, s00, u01), s0, N2(u1, s1, u2))
        | T(u0') -> T(N3(u0', s0, u1, s1, u2))
      else if x < s1 then
        match tttree__add_rec x u1 with
        (*    s0     s10      s1
           u0    u10      u11    u2 *)
        | S(u10, s10, u11) ->
           S(N2(u0, s0, u10), s10, N2(u11, s1, u2))
        | T(u1') -> T(N3(u0, s0, u1', s1, u2))
      else
        match tttree__add_rec x u2 with
        | S(u20, s20, u21) ->
           (*    s0    s1     s21
              u0    u1    u20     u21 *)
           S(N2(u0, s0, u1), s1, N2(u20, s20, u21))
        | T(u2') -> T(N3(u0, s0, u1, s1, u2')))
;;

let rec tttree_add x t =
  match t with
  | Empty -> Singleton x
  | Singleton y ->
     let u, v = if x < y then (x, y) else (y, x) in
     TTTree (N2(Leaf u, v, Leaf v))
  | TTTree t' ->
     match tttree__add_rec x t' with
     | S(t0, s0, t1) -> TTTree(N2(t0, s0, t1))
     | T(t'') -> TTTree(t'')
;;

let rec tttree__lookup x t =
  match t with
  | Leaf y -> x = y
  | N2 (p, a, q) ->
     if x < a then tttree__lookup x p else tttree__lookup x q
  | N3 (p, a, q, b, r) ->
     if x < a then tttree__lookup x p
     else if x < b then tttree__lookup x q
     else tttree__lookup x r
;;

let tttree_lookup x t =
  match t with
  | Empty -> false
  | Singleton y -> x = y
  | TTTree t' -> tttree__lookup x t'
;;

let rec tttree__remove_rec x t =
  match t with
  | Leaf y ->
     if x = y then E else MC(t)
  | N2 (u0, s0, u1) ->
     if x < s0 then
       (match tttree__remove_rec x u0 with
        | E -> SC(u1)
        | SC(u00) ->
           (*      s0
                u0    u1
                |
               u00         *)
           (match u1 with
              N2 (u10, s10, u11) ->
                 (*       s0
                      u0      u1
                      |       /\
                      u00   u10 u11 *)
               SC(N3(u00, s0, u10, s10, u11))
            | N3 (u10, s10, u11, s11, u12) ->
                 (*       s0
                      u0      u1
                      |       /|\
                     u00   u10u11u12 *)
               MC(N2(N2(u00, s0, u10), s10, N2(u11, s11, u12)))
            | _ -> assert false)
        | MC(u0') -> MC(N2(u0', s0, u1)))
     else
       (match tttree__remove_rec x u1 with
        | E -> SC(u0)
        | SC(u10) ->
           (match u0 with
            | N2 (u00, s00, u01) ->
               SC(N3(u00, s00, u01, s0, u10))
            | N3 (u00, s00, u01, s01, u02) ->
               MC(N2(N2(u00, s00, u01), s01, N2(u02, s0, u10)))
            | _ -> assert false)
        | MC(u1') -> MC(N2(u0, s0, u1')))
  | N3 (u0, s0, u1, s1, u2) ->
     (*    s0    s1
        u0    u1    u2 *)
     if x < s0 then
       (match tttree__remove_rec x u0 with
        | E -> MC(N2(u1, s1, u2))
        | SC(u00) ->
           (match u1 with
            | N2 (u10, s10, u11) -> 
               (*         s0    s1
                      u0     u1    u2
                      |      /\
                      u00  u10 u11 *)
               MC(N2(N3(u00, s0, u10, s10, u11), s1, u2))
            | N3 (u10, s10, u11, s11, u12) ->
               (*        s0       s1
                      u0      u1      u2
                       |     /|\
                     u00  u10u11u12 *)
               MC(N3(N2(u00, s0, u10), s10, N2(u11, s11, u12), s1, u2))
            | _ -> assert false)
        | MC(u0') -> MC(N3(u0', s0, u1, s1, u2)))
     else if x < s1 then
       (match tttree__remove_rec x u1 with
        | E -> MC(N2(u0, s1, u2))
        | SC(u10) ->
           (*      s0    s1
                u0    u1    u2
                      |          *)
           (match u0 with
            | N2 (u00, s00, u01) ->
               (*      s0    s1
                    u0    u1    u2
                    /\    |
                 u00 u01  u10                *)
               MC(N2(N3(u00, s00, u01, s0, u10), s1, u2))
            | N3 (u00, s00, u01, s01, u02) ->
               (*      s0    s1
                    u0    u1    u2
                    /|\    |
                u00u01u02 u10                *)
               MC(N3(N2(u00, s00, u01), s01, N2(u02, s0, u10), s1, u2))
            | _ -> assert false)
        | MC(u1') -> MC(N3(u0, s0, u1', s1, u2)))
     else
       (match tttree__remove_rec x u2 with
        | E -> MC(N2(u0, s0, u1))
        | SC(u20) ->
           (*      s0    s1
                u0    u1    u2
                            |
                            u20  *)
           (match u1 with
              N2 (u10, s10, u11) ->
               (*      s0    s1
                    u0    u1     u2
                          /\     |
                        u10 u11  u20  *)
               MC(N2(u0, s0, N3(u10, s10, u11, s1, u20)))
            | N3 (u10, s10, u11, s11, u12) ->
               (*      s0     s1
                    u0     u1     u2
                          /|\     |
                       u10u11u12  u20  *)
               MC(N3(u0, s0, N2(u10, s10, u11), s11, N2(u12, s1, u20)))
            | _ -> assert false)
        | MC(u2') -> MC(N3(u0, s0, u1, s1, u2')))
;;

let tttree_remove x t =
  match t with
  | Empty -> Empty
  | Singleton y -> if x = y then Empty else t
  | TTTree t' ->
     match tttree__remove_rec x t' with
     | E -> Empty
     | SC(Leaf x) -> Singleton x
     | SC(t'') -> TTTree t''
     | MC(t'') -> TTTree t''
;;

(** end hidden *)
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
