(** begin my answer *)

let rec gcd a b =
  if b = 0 then
    a
  else
    gcd b (a mod b);;
(** end my answer *)

let main () =
  assert (gcd 1499276220   463728183   = 6873);
  assert (gcd 256381708674 48941846742 = 35094);
  assert (gcd 8619803849   3861314192  = 11437);
  Printf.printf "OK\n"
;;

main()
