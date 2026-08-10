(* get current time in ns *)
exception Couldnt_get_time
;;

let time_ns () = 
  match Base.Int63.to_int (Time_now.nanoseconds_since_unix_epoch()) with
    Some(t) -> t
  | None -> raise Couldnt_get_time
;;

(* ------------- random number generator ------------- *)

(* random number generator state *)
class rand_state x = object
  val mutable x = x
  method next () =
    let a = 0x5DEECE66D in
    let c = 0xB in
    let m = (Int.shift_left 1 48) - 1 in
    x <- (a * x + c) land m; Int.shift_right x 17
end

(* binary search tree *)
type bin_search_tree =
  Empty
| Node of (int * int * bin_search_tree * int * bin_search_tree) (* val, lc, left, rc, right *)
;;

(* insert x to a tree *)
let rec insert t x =
  match t with
    Empty -> Node(x, 0, Empty, 0, Empty)
  | Node(v, lc, left, rc, right) ->
     if x <= v then
       Node(v, lc + 1, (insert left x), rc, right)
     else
       Node(v, lc, left, rc + 1, (insert right x))
;;

(* remove n-th element *)
let rec remove_nth t n = 
  match t with
    Empty -> failwith "remove_nth: empty tree"
  | Node(v, lc, left, rc, right) ->
     if n < lc then
       let (v', left') = remove_nth left n in
       (v', Node(v, lc - 1, left', rc, right))
     else if n == lc then
       if lc < rc then
         let (v', right') = remove_nth right 0 in
         (v, Node(v', lc, left, rc - 1, right'))
       else
         match left with
           Empty -> (v, Empty)
         | _ ->
            let (v', left') = remove_nth left (lc - 1) in
            (v, Node(v', lc - 1, left', rc, right))
     else
       let (v', right') = remove_nth right (n - lc - 1) in
       (v', Node(v, lc, left, rc - 1, right'))
;;

(* dump the first n elements *)
let rec dump t n =
  match t with
    Empty -> ()
  | Node(v, lc, left, _rc, right) ->
     if n > 0 then
       let _ = dump left n in
       if lc < n then
         let _ = Printf.printf "%d " v in
         if lc + 1 < n then
           dump right (n - lc - 1)
;;

let main () =
  let _ = Printf.printf "lang = ocaml\n" in
  let argv = Sys.argv in
  let argc = Array.length argv in
  let m = if argc > 1 then int_of_string argv.(1) else 100 * 1000 in
  let n = if argc > 2 then int_of_string argv.(2) else m / 2 in
  let rg = new rand_state 123456 in
  (* insert m elements *)
  let _ = Printf.printf "make a tree of m = %d nodes\n" m in
  let rec insert_loop i m t =
    if i = m then
      t
    else
       let x = (rg#next ()) mod 1000000000 in
       let t' = insert t x in
       insert_loop (i + 1) m t'
  in
  let t = insert_loop 0 m Empty in
  (* insert an element and remove the maximum element *)
  let _ = Printf.printf "insert/delete n = %d times\n" n in
  (* let h = mk_heap n_records in *)
  let rec insert_delete_loop i n t =
    if i = n then
      t
    else
      let x = (rg#next ()) mod 1000000000 in
      let k = (rg#next ()) mod (m + 1) in
      let t' = insert t x in
      let _v, t'' = remove_nth t' k in
      insert_delete_loop (i + 1) n t''
  in
  let t0 = time_ns () in 
  (* repeat n times removing an element and inserting another *)
  let t = insert_delete_loop 0 n t in
  let t1 = time_ns () in
  let _ = Printf.printf "dump the first 5 elements in the tree : " in
  let _ = dump t 5 in
  let _ = Printf.printf "\n" in
  Printf.printf "took %d nsec to insert/remove %d elements (%f nsec/elem)\n" (t1 - t0) n ((Float.of_int (t1 - t0)) /. (Float.of_int n))
;;

main()

