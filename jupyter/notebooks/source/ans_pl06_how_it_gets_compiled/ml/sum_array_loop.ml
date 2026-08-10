
let rec sum_array_loop a =
  let s = ref 0.0 in
  for i = 0 to Array.length a do
    s := !s +. a.(i)
  done;
  s
;;
