(** begin my answer *)

let rec affine_recurrence_simple_tail_rec a b m xm n =
  if m = n then
    xm
  else
    let xm_1 = a *. xm +. b in
    affine_recurrence_simple_tail_rec a b (m + 1) xm_1 n
;;
      
let affine_recurrence_simple_tail a b c n = affine_recurrence_simple_tail_rec a b 0 c n
;;
let rec affine_recurrence_fast_tail_rec a b m xm n =
  if m = n then
    xm
  else if (n - m) mod 2 = 0 then
    affine_recurrence_fast_tail_rec (a *. a) (a *. b +. b) m xm ((m + n) / 2)
  else
    let xm_1 = a *. xm +. b in
    affine_recurrence_fast_tail_rec a b (m + 1) xm_1 n
;;
      
let affine_recurrence_fast_tail a b c n = affine_recurrence_fast_tail_rec a b 0 c n
(** end my answer *)

let main () =
  assert (Float.abs (affine_recurrence_fast_tail   0.9999 1.0 2.0 100000  -. 9999.5463184) < 1.0e-6);
  assert (Float.abs (affine_recurrence_simple_tail 0.9999 1.0 2.0 100000  -. 9999.5463184) < 1.0e-6);
  assert (Float.abs (affine_recurrence_fast_tail   0.9999 1.0 2.0 1000000 -. 10000.0) < 1.0e-6);
  assert (Float.abs (affine_recurrence_simple_tail 0.9999 1.0 2.0 1000000 -. 10000.0) < 1.0e-6);
  Printf.printf "OK\n"
;;

main()
