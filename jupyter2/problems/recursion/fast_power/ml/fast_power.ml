let rec power_iter a n =
  let p = ref 1.0 in
  (for i = 1 to n do
     p := !p *. a
   done;
   !p)
(** begin my answer *)

(** end my answer *)

let main () =
  assert (Float.abs (power_simple (1.0 +. 1.0 /. 10.0)      10        -. 2.59374246) < 1.0e-7);
  assert (Float.abs (power_fast (1.0 +. 1.0 /. 10.0)        10        -. 2.59374246) < 1.0e-7);
  assert (Float.abs (power_simple (1.0 +. 1.0 /. 100.0)     100       -. 2.70481383) < 1.0e-7);
  assert (Float.abs (power_fast (1.0 +. 1.0 /. 100.0)       100       -. 2.70481383) < 1.0e-7);
  assert (Float.abs (power_fast (1.0 +. 1.0 /. 1000000.0)   1000000   -. 2.71828047) < 1.0e-7);
  assert (Float.abs (power_iter (1.0 +. 1.0 /. 1000000.0)   1000000   -. 2.71828047) < 1.0e-7);
  assert (Float.abs (power_fast (1.0 +. 1.0 /. 10000000.0)  10000000  -. 2.71828169) < 1.0e-7);
  assert (Float.abs (power_iter (1.0 +. 1.0 /. 10000000.0)  10000000  -. 2.71828169) < 1.0e-7);
  assert (Float.abs (power_fast (1.0 +. 1.0 /. 100000000.0) 100000000 -. 2.71828179) < 1.0e-7);
  assert (Float.abs (power_iter (1.0 +. 1.0 /. 100000000.0) 100000000 -. 2.71828180) < 1.0e-7);
  Printf.printf "OK\n"
;;

main()
