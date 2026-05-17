(** begin my answer *)

(** begin hidden *)
type bintree = Empty | Node of (bintree * bintree);;

let rec mk_maximally_balanced_bintree n =
  if n = 0 then Empty
  else
    let ls = n / 2 in
    let rs = n - 1 - ls in
    Node (mk_maximally_balanced_bintree ls, mk_maximally_balanced_bintree rs)
;;

let rec count_nodes t =
  match t with
    Empty -> 0
  | Node (l, r) ->
     let lc = count_nodes l in
     let rc = count_nodes r in
     if lc <> -1 && rc <> -1 && (lc = rc || lc = rc + 1) then
       lc + rc + 1
     else
       -1
;;
(** end hidden *)
(** end my answer *)

let main () =
  assert (count_nodes (mk_maximally_balanced_bintree 10)      = 10);
  assert (count_nodes (mk_maximally_balanced_bintree 100)     = 100);
  assert (count_nodes (mk_maximally_balanced_bintree 1000)    = 1000);
  assert (count_nodes (mk_maximally_balanced_bintree 10000)   = 10000);
  assert (count_nodes (mk_maximally_balanced_bintree 100000)  = 100000);
  assert (count_nodes (mk_maximally_balanced_bintree 1000000) = 1000000);
  Printf.printf "OK\n"
;;

main()
