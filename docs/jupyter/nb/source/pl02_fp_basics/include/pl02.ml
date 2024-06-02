(** if label == "A simple recurrence" *)
let rec a n =
  if n = 0 then
    1.0
  else
    0.9 *. (a (n - 1)) +. 2.0
;;
(** endif *)
(** if label == "A simple recurrence test" *)
let float64_close x y eps =
  if abs_float (x -. y) > eps then
    Printf.printf "NG\n"
  else
    Printf.printf "OK\n"
;;
(** if 0 *)
let a_test () =
(** endif *)
    float64_close (a 0)   1.0        1.0e-6;
    float64_close (a 10)  13.3751096 1.0e-6;
    float64_close (a 100) 19.9994953 1.0e-6;
    float64_close (a 300) 20.0       1.0e-6;
    flush_all ()
;;
(** endif *)
(** if label == "The smallest divisor" *)
let rec smallest_divisor_geq n x =
  if n mod x = 0 then
    x
  else if n < x * x then
    n
  else
    smallest_divisor_geq n (x + 1)
;;
(** endif *)
(** if label == "The smallest divisor test" *)
let int64_eq x y =
  if x == y then
    Printf.printf "OK\n"
  else
    Printf.printf "NG\n"
;;
(** if 0 *)
let smallest_divisor_geq_test () =
(** endif *)
    int64_eq (smallest_divisor_geq 2          2) 2;
    int64_eq (smallest_divisor_geq 3          2) 3;
    int64_eq (smallest_divisor_geq (13 * 17)  2) 13;
    int64_eq (smallest_divisor_geq 6700417    2) 6700417;
    flush_all ()
;;
(** endif *)
(** if label == "Factorize" *)
let rec factorize n =
  if n = 1 then
    []
  else
    let x = smallest_divisor_geq n 2 in
    x :: (factorize (n / x))
;;
(** endif *)
(** if label == "Factorize test" *)
let int64_list_eq a b =
  if a = b then
    Printf.printf "OK\n"
  else 
    Printf.printf "NG\n"
;;
(** if 0 *)
let factorize_test () =
(** endif *)
    int64_list_eq (factorize 1)   [];
    int64_list_eq (factorize 5)   [5];
    int64_list_eq (factorize 64)  [2; 2; 2; 2; 2; 2];
    int64_list_eq (factorize 105) [3; 5; 7];
    flush_all ()
;;
(** endif *)
(** if label == "Subset sum" *)
let rec subset_sum a v =
  if v = 0 then
    Some(List.map (fun _ -> 0) a)
  else if v < 0 then
    None
  else
    match a with
      [] -> None
    | a0 :: ar ->
       match subset_sum ar (v - a0) with
         Some(k1) -> Some(1 :: k1)
       | None -> match subset_sum ar v with
                   Some(k0) -> Some(0 :: k0)
                 | None -> None
;;
(** endif *)
(** if label == "Subset sum test" *)
(** if 0 *)
let subset_sum_test () =
(** endif *)
  int64_list_eq (subset_sum [1; 2; 3; 4; 5] 8) (Some([1; 1; 0; 0; 1]));
  int64_list_eq (subset_sum [33; 28; 56; 35; 19; 46; 25; 58; 17; 49; 33; 39; 37; 33; 24; 52] 233)
    (Some([1; 1; 1; 1; 1; 0; 1; 0; 0; 0; 0; 0; 1; 0; 0; 0]));
  int64_list_eq (subset_sum [30; 37; 46; 41; 14; 46; 44; 40; 46; 30; 46; 28; 33; 31; 56] 171)
    (Some([1; 1; 1; 0; 1; 0; 1; 0; 0; 0; 0; 0; 0; 0; 0]));
  int64_list_eq (subset_sum [47; 39; 15; 27; 52; 31; 39; 54; 20; 26; 38; 19; 35; 28] 440) None;
  int64_list_eq (subset_sum [16; 24; 13; 20; 24; 13; 11; 31; 29; 44] 222) None;
  flush_all ()
;;
(** endif *)
(** if 0 *)
let main () =
  Printf.printf "a\n";
  a_test ();
  Printf.printf "smallest_divisor_geq\n";
  smallest_divisor_geq_test ();
  Printf.printf "factorize\n";
  factorize_test ();
  Printf.printf "subset_sum\n";
  subset_sum_test ()
;;
main ()
;;
(** endif *)
