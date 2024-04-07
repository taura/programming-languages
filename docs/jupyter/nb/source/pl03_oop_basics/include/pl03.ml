(** if label == "Define data structure representing a rectangle and an ellipse" *)
(* done below *)
(** endif *)
(** if label == "Define a method that computes the area of rect/ellipse" *)
class rect x y width height = object
  method area = float(width * height)
end
;;                            
let pi = (atan2 1.0 1.0) *. 4.0
;;
class ellipse x y rx ry = object
  method area =
    float(rx * ry) *. pi
end
;;
(** endif *)
(** if label == "Create an array/a list/a vector/a slice"  *)
let shapes = [new rect 0 0 100 100; new ellipse 0 0 100 50]
;;             
(** endif *)
(** if label == "Scan an array of shapes"  *)
let rec sum_area shapes =
  match shapes with
    [] -> 0.0
  | h::r -> h#area +. (sum_area r)
;;
sum_area shapes
;;
(** endif *)
