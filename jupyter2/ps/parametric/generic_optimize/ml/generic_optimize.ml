(** begin my answer *)

(** begin hidden *)
let arange a b n =
  let dx = (b -. a) /. float_of_int (n - 1) in
  object 
    val mutable i = 0
    method next =
      if i = n then None
      else
        let x = a +. dx *. float_of_int i in
        let _ = i <- i + 1 in
        Some x
  end

let arange2d x0 x1 m y0 y1 n =
  let dx = (x1 -. x0) /. float_of_int (m - 1) in
  let dy = (y1 -. y0) /. float_of_int (n - 1) in
  object 
    val mutable i = 0
    val mutable j = 0
    method next =
      if i = m then
        None
      else 
        let x = x0 +. dx *. float_of_int i in
        let y = y0 +. dy *. float_of_int j in
        let _ = i <- if j + 1 = n then i + 1 else i in
        let _ = j <- if j + 1 = n then 0 else j + 1 in
        Some (x, y)
  end

let optimize f rng =
  let rec iter x miny =
    match (x, miny) with
    | (None, _) -> miny
    | (Some x, None) ->
       iter rng#next (Some(f x))
    | (Some x, Some(miny)) ->
       let y = f x in
       let next = rng#next in
       if y < miny then
         iter next (Some(y))
       else
         iter next (Some(miny))
  in
  iter (rng#next) None
(** end hidden *)
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
