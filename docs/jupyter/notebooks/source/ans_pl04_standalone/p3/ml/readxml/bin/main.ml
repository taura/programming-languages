let (ch, _) = Markup.file Sys.argv.(1) in
    let _ = Markup.parse_xml ch in
    Printf.printf "%s\n" "OK"
