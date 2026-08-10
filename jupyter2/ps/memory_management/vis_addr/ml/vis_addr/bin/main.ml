(* get current time in ns *)
exception Couldnt_get_time
;;

let time_ns () = 
  match Base.Int63.to_int (Time_now.nanoseconds_since_unix_epoch()) with
    Some(t) -> t
  | None -> raise Couldnt_get_time
;;

let main () = 
  let argv = Sys.argv in
  let argc = Array.length argv in
  let s = if argc > 1 then int_of_string argv.(1) else 1000 * 1000 in
  let m = if argc > 2 then int_of_string argv.(2) else 10 in
  let n = if argc > 3 then int_of_string argv.(3) else m * 10 in
  let a = Array.make m (Array.make 1 0) in
  let rec allocate_loop i =
    if i < n then
      let t0 = time_ns() in
      let b = Array.make s i in
      let t1 = time_ns() in
      let p = Obj.magic (Obj.repr b) in
      let _ = a.(i mod m) <- b in
      let _ = Printf.printf "%d %d %d\n" i p (t1 - t0) in
      allocate_loop (i + 1)
  in
  allocate_loop 0
;;

main ()

