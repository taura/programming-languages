(* ----------- utility ----------- *)

(* t1 = f 0 t0; 
   t2 = f 1 t1;
      ...
   tn = f (n-1) t_{n-1} *)
let iter f n t0 =
  let rec loop i t =
    if i = n then
      t
    else
      let t' = f i t in
      loop (i + 1) t'
  in
  loop 0 t0
;;

(* swap a[i] and a[j] *)
let swap a i j =
  let ai = a.(i) in 
  let aj = a.(j) in
  a.(i) <- aj;
  a.(j) <- ai
;;

(* get current time in ns *)
exception Couldnt_get_time
;;

let time_ns () = 
  match Base.Int63.to_int (Time_now.nanoseconds_since_unix_epoch()) with
    Some(t) -> t
  | None -> raise Couldnt_get_time
;;

(* ------------ this is only for recording (nothing to do with binary search tree) ------------ *)

(* allocation record that records how long an allocation took *)
type event = {
    stamp : int;                (* when it happened *)
    dt : int;                   (* how long it took *)
  };;

(* heap data structure that keeps track of longest allocations
   (this heap should not be confused with heap memory of programming languages). *)
type event_heap = {
    mutable n : int;    (* n : actual no of elements *)
    a : event array;    (* array of m elements *)
    (* invariant a[p] < a[2p+1], a[p] < a[2p+2] *)
    start_stamp : int;          (* start_stamp *)
  };;

(* create a heap of m allocation_records *)
let mk_heap m =
  {n = 0; a = Array.make m {stamp = 0; dt = 0}; start_stamp = time_ns()}
;;

(* add an element x to heap h *)
let add ({n; a; _} as h) x =
  let _ = assert (n >= 0) in
  let _ = assert (n < Array.length a) in
  let n = n + 1 in
  let _ = a.(n - 1) <- x in
  let rec loop c =
    if c > 0 then
      let p = (c - 1) / 2 in
      let _ = if a.(c).dt < a.(p).dt then swap a p c in
      loop p
  in
  let _ = loop (n - 1) in
  let _ = h.n <- n in
  ()
;;

(* remove the smallest element from h *)
let remove_smallest ({n; a; _} as h) =
  let _ = assert (n <= Array.length a) in
  let _ = assert (n > 0) in
  let x = a.(0) in
  let _ = a.(0) <- a.(n - 1) in
  let n = n - 1 in
  let rec loop p =
    if 2 * p + 1 < n then
      let l = 2 * p + 1 in
      let r = 2 * p + 2 in
      let c = if r < n && a.(r).dt < a.(l).dt then r else l in
      let _ = if a.(c).dt < a.(p).dt then swap a p c in
      loop c
  in
  let _ = loop 0 in
  let _ = h.n <- n in
  x
;;

(* debugprint heap *)
let print_heap ({n; a; _} as h) filename = 
  let _ = assert (n >= 0) in
  let _ = assert (n <= Array.length a) in
  let wp = open_out filename in
  (* let _ = Printf.fprintf wp "stamp,dt\n" in *)
  let print_elem _ () = 
    let {stamp; dt} = remove_smallest h in
    Printf.fprintf wp "%d,%d\n" stamp dt
  in
  let _ = iter print_elem n () in
  close_out wp
;;

(* add an allocation record to ar
   if h has a room for another element, insert AllocationRecord(no, stamp, dt)
   otherwise if dt is larger than the smallest dt in h, then
   replace it with AllocationRecord(no, stamp, dt) *)
let add_record ({n; a; start_stamp} as h) dt = 
  let m = (Array.length a) in
  let _ = if n == m && a.(0).dt < dt then let _ = remove_smallest h in () in
  if h.n < m then
    let stamp = time_ns() - start_stamp in
    add h {stamp = stamp; dt = dt}
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
| Node of (int * bin_search_tree * bin_search_tree)
;;

(* insert x to a tree *)
let rec insert t x =
  match t with
    Empty -> Node(x, Empty, Empty)
  | Node(v, left, right) ->
     if x <= v then
       Node(v, (insert left x), right)
     else
       Node(v, left, (insert right x))
;;

(* remove the maximum element from a tree *)
let rec remove_max t =
  match t with
    Empty -> Empty
  | Node(_, left, Empty) -> left
  | Node(v, left, right) ->
     Node(v, left, (remove_max right))
;;

(* find the maximum element of a tree *)
let rec peek_max t = 
  match t with
    Empty -> None
  | Node(v, _, Empty) -> Some(v)
  | Node(_, _, right) -> peek_max right
;;

let main () =
  let _ = Printf.printf "lang = ocaml\n" in
  let argv = Sys.argv in
  let argc = Array.length argv in
  let m = if argc > 1 then int_of_string argv.(1) else 100 * 1000 in
  let n = if argc > 2 then int_of_string argv.(2) else m / 2 in
  let n_records = if argc > 3 then int_of_string argv.(3) else max (n / 1000) 100 in
  let rg = new rand_state 123456 in
  (* insert an element *)
  let ins _ t =
    let x = (rg#next ()) mod 1000000000 in
    let t' = insert t x in
    t'
  in
  (* insert m elements *)
  let _ = Printf.printf "make a tree of m = %d nodes\n" m in
  let t = iter ins m Empty in
  (* insert an element and remove the maximum element *)
  let _ = Printf.printf "insert/delete n = %d times\n" n in
  let h = mk_heap n_records in
  let ins_rem _ t =
    let x = (rg#next ()) mod 1000000000 in
    let s0 = time_ns() in
    let t'= insert t x in
    let t'' = remove_max t' in
    let s1 = time_ns() in
    let _ = add_record h (s1 - s0) in
    t''
  in
  let t0 = time_ns () in 
  (* repeat n times removing an element and inserting another *)
  let t = iter ins_rem n t in
  let t1 = time_ns () in 
  let _ = match peek_max t with
      None -> Printf.printf "\n"
    | Some(v) -> Printf.printf "%d th smallest value out of %d values v = %d\n" m (m + n) v
  in
  let _ = Printf.printf "took %d nsec to insert/remove %d elements\n" (t1 - t0) n in
  let alloc_log = "allocation-ocaml.csv" in
  let _ = Printf.printf "dump %d records that took longest to %s\n" n_records alloc_log in
  print_heap h alloc_log
;;

main()

