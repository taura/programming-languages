(** begin my answer *)

(** end my answer *)

let main () =
  assert ( is_leap_year 2000 );
  assert (not (is_leap_year 1900));
  assert ( is_leap_year 2024 );
  assert (not (is_leap_year 2023));
  Printf.printf "OK\n"
;;

main()
