open Minc
open Ast

let uop = function Pos -> "+" | Neg -> "-" | LNot -> "!" | BNot -> "~"
let bop = function
  | Add -> "+" | Sub -> "-" | Mul -> "*" | Div -> "/" | Mod -> "%"
  | Lt -> "<" | Gt -> ">" | Le -> "<=" | Ge -> ">="
  | Eq -> "==" | Ne -> "!="

let rec e = function
  | Int n -> string_of_int n
  | Var x -> x
  | Call (f, args) -> Printf.sprintf "%s(%s)" f (String.concat ", " (List.map e args))
  | Unary (o, x) -> Printf.sprintf "(%s%s)" (uop o) (e x)
  | Binary (o, a, b) -> Printf.sprintf "(%s %s %s)" (e a) (bop o) (e b)
  | Assign (a, b) -> Printf.sprintf "(%s = %s)" (e a) (e b)

let rec s ind st =
  let pad = String.make ind ' ' in
  match st with
  | Empty -> pad ^ ";\n"
  | Continue -> pad ^ "continue;\n"
  | Break -> pad ^ "break;\n"
  | Return ex -> Printf.sprintf "%sreturn %s;\n" pad (e ex)
  | Expr ex -> Printf.sprintf "%s%s;\n" pad (e ex)
  | Compound (ds, ss) ->
    let dl = List.map (fun d -> Printf.sprintf "%s  long %s;\n" pad d.vd_name) ds in
    Printf.sprintf "%s{\n%s%s%s}\n" pad (String.concat "" dl)
      (String.concat "" (List.map (s (ind + 2)) ss)) pad
  | If (c, t, None) -> Printf.sprintf "%sif (%s)\n%s" pad (e c) (s (ind + 2) t)
  | If (c, t, Some el) ->
    Printf.sprintf "%sif (%s)\n%s%selse\n%s" pad (e c) (s (ind + 2) t) pad (s (ind + 2) el)

let def = function
  | FunDef f ->
    let ps = String.concat ", " (List.map (fun p -> "long " ^ p.p_name) f.f_params) in
    Printf.sprintf "long %s(%s)\n%s" f.f_name ps (s 0 f.f_body)

let () =
  let src =
    "long fib(long n) {\n\
    \  if (n < 2) return n;\n\
    \  return fib(n - 1) + fib(n - 2);\n\
     }\n\
     long main() {\n\
    \  long x;\n\
    \  x = 11;\n\
    \  return fib(x) * -(2 + 3);\n\
     }\n"
  in
  match Parse.parse_string src with
  | Some prog -> List.iter (fun d -> print_string (def d)) prog
  | None -> exit 1
