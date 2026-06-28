let read_file path =
  let ic = open_in path in
  let s = In_channel.input_all ic in
  let () = close_in ic in
  s

let write_file path s =
  let oc = open_out path in
  let () = output_string oc s in
  close_out oc

let read_input () =
  if Array.length Sys.argv > 1 then read_file Sys.argv.(1)
  else In_channel.input_all stdin

let write_output asm =
  if Array.length Sys.argv > 2 then write_file Sys.argv.(2) asm
  else print_string asm

let compile src =
  let open Minc in
  match Parse.parse_string src with
  | None -> None
  | Some prog -> Codegen.gen_program prog

let main () =
  let src = read_input () in
  match compile src with
  | Some asm -> write_output asm
  | None -> exit 1

let () = main ()
