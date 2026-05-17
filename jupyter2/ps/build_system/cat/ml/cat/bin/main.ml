(* ml/cat/bin/main.ml *)
let main () =
  (* get command line arg *)
  let filename = Sys.argv.(1) in
  (* read file *)
  let ic = open_in filename in
  (* read the whole contents *)
  let contents = really_input_string ic (in_channel_length ic) in
  (* close the file *)
  close_in ic;
  (* print the contents *)
  print_string contents
;;

main ()
