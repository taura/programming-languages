(** begin my answer *)

(** begin hidden *)
let is_leap_year year =
  if year mod 400 = 0 then
    true
  else if year mod 100 = 0 then
    false
  else if year mod 4 = 0 then
    true
  else
    false;;
(** end hidden *)
(** end my answer *)

let main () =
  assert ( is_leap_year 2000 );
  assert (not (is_leap_year 1900));
  assert ( is_leap_year 2024 );
  assert (not (is_leap_year 2023));
  Printf.printf "OK\n"
;;

main()
