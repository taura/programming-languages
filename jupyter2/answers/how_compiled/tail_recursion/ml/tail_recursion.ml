let rec sum_array_tail a i n s =
  if i = n then
    s
  else
    sum_array_tail a (i + 1) n (s +. a.(i))
;;
