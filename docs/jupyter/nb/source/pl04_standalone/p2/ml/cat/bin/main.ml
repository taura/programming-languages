let ch = open_in_bin Sys.argv.(1) in
    let s = really_input_string ch (in_channel_length ch) in
    close_in ch;
    Printf.printf "%s" s
