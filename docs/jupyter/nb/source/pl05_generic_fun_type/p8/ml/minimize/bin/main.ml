let take_min min_xy x y =
  match min_xy with
    None -> Some((x, y))
  | Some((_, min_y)) ->
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
let main () = 
  match minimize (fun (x, y) -> x *. x +. y *. y)
          (new ellipse_generator 3.0 3.0 2.0 1.0 10000) with
    None ->
     Printf.printf "\n"
  | Some(((x, y), z)) ->
     Printf.printf "(x, y) = (%f, %f), f(x, y) = %f\n" x y z
;;
main()

