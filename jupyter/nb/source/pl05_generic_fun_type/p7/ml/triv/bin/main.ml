type 'a triv = Triv of 'a
;;

let triv_val(Triv(x)) = x

let main() = 
  let s = Triv(3) in
  let x = triv_val s in
  let t = Triv("hello") in
  let y = triv_val t in
  Printf.printf "%d\n" x;
  Printf.printf "%s\n" y
;;

main()
