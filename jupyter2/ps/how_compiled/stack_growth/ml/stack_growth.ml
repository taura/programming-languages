let rec sum_array_rec a n =
  if n = 0 then
    0.0
  else
    (sum_array_rec a (n - 1)) +. a.(n - 1)
;;
