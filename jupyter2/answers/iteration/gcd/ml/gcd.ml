(** begin my answer *)

let gcd a b =
  let x = ref a in
  let y = ref b in
  while !y <> 0 do
    let r = !x mod !y in
    x := !y;
    y := r
  done;
  !x;;
(** end my answer *)

let main () =
  assert (gcd 1499276220 463728183 = 6873);
  assert (gcd 256381708674 48941846742 = 35094);
  assert (gcd 8619803849 3861314192 = 11437);
  Printf.printf "OK\n"
;;

main()
