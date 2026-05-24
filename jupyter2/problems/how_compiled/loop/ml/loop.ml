let sum_array_loop a n =
  let s = ref 0.0 in
  for i = 0 to n do
    s := !s +. a.(i)
  done;
  !s
;;
