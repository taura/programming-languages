
let main () =
  let filename = Sys.argv.(1) in
  let doc = Readxml.parse filename in
  let d = Readxml.height doc in
  Printf.printf "%d\n" d
;;

main()
