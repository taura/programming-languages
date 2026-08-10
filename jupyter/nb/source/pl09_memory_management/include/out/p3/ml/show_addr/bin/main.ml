let main () = 
  let argv = Sys.argv in
  let argc = Array.length argv in
  let s = if argc > 1 then int_of_string argv.(1) else 1000 * 1000 in
  let m = if argc > 2 then int_of_string argv.(2) else 100 in
  let n = if argc > 3 then int_of_string argv.(3) else m * 10 in
  let sizeof_elem = 8 in
  let _ = if sizeof_elem * s * m > (1 lsl 30) then
            (Printf.printf "you'd better not allocate that much memory\n" ;
             Printf.printf "sizeof element(8) * s(%d) * m(%d) = %d > 1GB\n" s m (sizeof_elem * s * m);
             exit 1) in
  let b = Array.make s 0L in
  let a = Array.make m b in
  let rec allocate_loop i =
    if i < n then
      let b = Array.make s 0L in
      let p = Obj.magic (Obj.repr b) in
      let _ = a.(i mod m) <- b in
      let _ = Printf.printf "%d\t%d\n" i p in
      allocate_loop (i + 1)
  in
  allocate_loop 0
;;

main ()
