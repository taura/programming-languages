(** begin my answer *)

(** end my answer *)

let very_close a b =
  match a with
  | None -> false
  | Some a -> Float.abs (a -. b) < 1e-6

let main () =
  let f0 x = x *. (x -. 1.) in
  let f1 x = x *. (x -. 1.) *. (x -. 2.) in
  let f2 (x, y) = x *. x +. 2. *. y *. y +. 3. *. x *. y in
  let a0 = arange (-1.) 3. 10000 in
  let a1 = arange (-0.) 3. 10000 in
  let a2 = arange2d (-2.) 2. 10000 (-2.) 2. 1000 in
  let y0 = optimize f0 a0 in
  let y1 = optimize f1 a1 in
  let y2 = optimize f2 a2 in
  assert (very_close y0 (-0.25));
  assert (very_close y1 (-0.384900));
  assert (very_close y2 (-0.5));

  Printf.printf "OK\n"
;;

main()
