(** begin my answer *)

(** end my answer *)

let main () =
  assert (f 1 = 1);
  assert (f "hello" = "hello");
  assert (g 2 = [2]);
  assert (g "world" = ["world"]);
  let c0 = cell 0 in
  (assert (c0#get = 0);
   c0#put 42;
   assert (c0#get = 42));
  let c1 = cell "mimura" in
  (assert (c1#get = "mimura");
   c1#put "ohtake";
   assert (c1#get = "ohtake"));
  assert (h [] = None);
  assert (h [3] = Some 3);
  assert (h ["bye"] = Some "bye");
  Printf.printf "OK\n"
;;

main()
