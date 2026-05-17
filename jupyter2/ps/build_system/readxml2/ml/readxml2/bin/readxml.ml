let parse filename =
  (* read file *)
  let ic = open_in filename in
  (* read the whole contents *)
  let contents = really_input_string ic (in_channel_length ic) in
  (* close the file *)
  let _ = close_in ic in
  (* print the contents *)
  Xml.parse_string contents

let rec height x = match x with
  | Xml.Element (_, _, children)
    -> 1 + List.fold_left (fun acc child -> max acc (height child)) 0 children
  | _ -> 0
