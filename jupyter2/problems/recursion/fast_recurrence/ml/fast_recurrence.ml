let rec affine_recurrence_iter a b c n =
  let x = ref c in
  for i = 1 to n do
    x := a *. !x +. b
  done;
  !x
;;
(** begin my answer *)

(** end my answer *)

let main () =
  assert (Float.abs (affine_recurrence_simple 0.9    1.0 2.0 100     -. 9.9997875) < 1.0e-6);
  assert (Float.abs (affine_recurrence_simple 0.99   1.0 2.0 1000    -. 99.9957692) < 1.0e-6);
  assert (Float.abs (affine_recurrence_fast   0.99   1.0 2.0 1000    -. 99.9957692) < 1.0e-6);
  assert (Float.abs (affine_recurrence_fast   0.99   1.0 2.0 10000   -. 100.0) < 1.0e-6);
  assert (Float.abs (affine_recurrence_fast   0.999  1.0 2.0 10000   -. 999.9549170) < 1.0e-6);
  assert (Float.abs (affine_recurrence_fast   0.999  1.0 2.0 100000  -. 1000.0) < 1.0e-6);
  assert (Float.abs (affine_recurrence_fast   0.9999 1.0 2.0 100000  -. 9999.5463184) < 1.0e-6);
  assert (Float.abs (affine_recurrence_iter   0.9999 1.0 2.0 100000  -. 9999.5463184) < 1.0e-6);
  assert (Float.abs (affine_recurrence_fast   0.9999 1.0 2.0 1000000 -. 10000.0) < 1.0e-6);
  assert (Float.abs (affine_recurrence_iter   0.9999 1.0 2.0 1000000 -. 10000.0) < 1.0e-6);
  Printf.printf "OK\n"
;;

main()
