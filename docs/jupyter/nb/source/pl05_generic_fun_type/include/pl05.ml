(** if label == "A function that takes a function"  *)
let f g = g 1.0;;
(** endif *)
(** if label == "A domain class for a floating point number"  *)
class random_float_generator a b n = object
  val mutable i = 0
  method next =
    if i < n then
      let x = a +. (b -. a) *. (Random.float 1.0) in
      let _ = i <- i + 1 in
      Some(x)
    else
      None
end
;;
(** endif *)
(** if 0 *)
let print_random() = 
  let rfg = new random_float_generator 2.0 3.0 10 in
  let rec loop () =
    match rfg#next with
      None -> ()
    | Some(f) -> Printf.printf "%f\n" f; loop ()
  in loop()
;;
(** endif *)
(** if label == "A minimizer for float -> float functions" *)
let take_min min_xy x y =
  match min_xy with
    None -> Some((x, y))
  | Some((min_x, min_y)) ->
     if y < min_y then
       Some((x, y))
     else
       min_xy
;;
let minimize f rfg =
  let rec loop min_xy =
    match rfg#next with
      None -> min_xy
    | Some(x) ->
       let y = f x in
       let min_xy = take_min min_xy x y in
       loop min_xy
  in loop None
;;
(** endif *)
(** if label == "Apply float -> float minimizer"  *)
minimize (fun x -> x *. (x -. 1.0) *. (x -. 2.0)) (new random_float_generator 0.0 2.0 10000)
;;
(** endif *)
(** if label == "A somewhat generic float -> float minimizer" *)
(* same as above (Problem 3) *)
(** endif *)
(** if label == "Apply a somewhat generic float -> float minimizer" *)
(* same as above (Problem 4) *)
(** endif *)
(** if label == "Define a trivial generic type and a function"  *)
type 'a triv = Triv of 'a
;;
let triv_val (Triv(x)) = x
;;
(** endif *)
(** if label == "A generic T -> float minimizer" *)
(* same as above (Problem 3) *)
(** endif *)
(** if label == "Apply a generic T -> float minimizer" *)
class ellipse_generator x0 y0 a b n = object
  val mutable i = 0
  method next =
    let rec loop () = 
      if i < n then
        let rx = (Random.float 2.0) -. 1.0 in
        let ry = (Random.float 2.0) -. 1.0 in
        if rx *. rx +. ry *. ry <= 1.0 then
          let x = x0 +. a *. rx in
          let y = y0 +. b *. ry in
          let _ = i <- i + 1 in
          Some((x, y))
        else
          loop ()
      else
        None
    in loop ()
end
;;
minimize (fun (x, y) -> x *. x +. y *. y) (new ellipse_generator 3.0 3.0 2.0 1.0 10000)
;;
(** endif *)
