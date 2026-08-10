open Ast

let ( let* ) = Option.bind

(* report an error at the point it occurs and return None *)
let fail msg =
  let () = Printf.eprintf "codegen error: %s\n" msg in
  None

(* run f on each element, stopping at the first None *)
let rec iter_opt f = function
  | [] -> Some ()
  | x :: xs ->
    let* () = f x in
    iter_opt f xs

(* like iter_opt but also passes the 0-based index *)
let iteri_opt f xs =
  let rec go i = function
    | [] -> Some ()
    | x :: xs ->
      let* () = f i x in
      go (i + 1) xs
  in
  go 0 xs

type env = {
  buf      : Buffer.t;
  offsets  : (string, int) Hashtbl.t;
  mutable label_id : int;
  prefix    : string;
  ret_label : string;
  mutable loops : (string * string) list;
}

let emit env fmt =
  Printf.ksprintf
    (fun s ->
       Buffer.add_string env.buf s;
       Buffer.add_char env.buf '\n')
    fmt

let fresh_label env =
  let n = env.label_id in
  env.label_id <- n + 1;
  Printf.sprintf ".L%s_%d" env.prefix n

let push env = emit env "\tstr\tx0, [sp, #-16]!"
let pop env reg = emit env "\tldr\t%s, [sp], #16" reg

let align16 n = (n + 15) / 16 * 16

let assign_offsets env params body =
  let next = ref 0 in
  let alloc name =
    next := !next + 8;
    Hashtbl.replace env.offsets name (- !next)
  in
  List.iteri
    (fun i p ->
       if i < 8 then alloc p.p_name
       else Hashtbl.replace env.offsets p.p_name (16 + 8 * (i - 8)))
    params;
  let rec scan = function
    | Compound (ds, ss) ->
      List.iter (fun d -> alloc d.vd_name) ds;
      List.iter scan ss
    | If (_, t, e) ->
      let () = scan t in
      (match e with Some s -> scan s | None -> ())
    | While (_, b) -> scan b
    | Empty | Continue | Break | Return _ | Expr _ -> ()
  in
  let () = scan body in
  align16 !next

let offset_of env name =
  match Hashtbl.find_opt env.offsets name with
  | Some off -> Some off
  | None -> fail (Printf.sprintf "undefined variable %s" name)

let rec gen_expr env e =
  match e with
  | Int n ->
    let () = emit env "\tmov\tx0, #%d" n in
    Some ()
  | Var name ->
    let* off = offset_of env name in
    let () = emit env "\tldr\tx0, [x29, #%d]" off in
    Some ()
  | Assign (Var name, rhs) ->
    let* () = gen_expr env rhs in
    let* off = offset_of env name in
    let () = emit env "\tstr\tx0, [x29, #%d]" off in
    Some ()
  | Assign (_, _) ->
    fail "left-hand side of assignment must be a variable"
  | Unary (op, e) ->
    let* () = gen_expr env e in
    gen_unop env op
  | Binary (op, a, b) ->
    let* () = gen_expr env a in
    let () = push env in
    let* () = gen_expr env b in
    let () = pop env "x1" in
    gen_binop env op
  | Call (f, args) -> gen_call env f args

and gen_unop env op =
  match op with
  | Pos -> Some ()
  | Neg ->
    let () = emit env "\tneg\tx0, x0" in
    Some ()
  | BNot ->
    let () = emit env "\tmvn\tx0, x0" in
    Some ()
  | LNot ->
    let () = emit env "\tcmp\tx0, #0" in
    let () = emit env "\tcset\tx0, eq" in
    Some ()

and gen_binop env op =
  match op with
  | Add ->
    let () = emit env "\tadd\tx0, x1, x0" in
    Some ()
  | Sub ->
    let () = emit env "\tsub\tx0, x1, x0" in
    Some ()
  | Mul ->
    let () = emit env "\tmul\tx0, x1, x0" in
    Some ()
  | Div ->
    let () = emit env "\tsdiv\tx0, x1, x0" in
    Some ()
  | Mod ->
    let () = emit env "\tsdiv\tx2, x1, x0" in
    let () = emit env "\tmsub\tx0, x2, x0, x1" in
    Some ()
  | Lt -> cmp_set env "lt"
  | Gt -> cmp_set env "gt"
  | Le -> cmp_set env "le"
  | Ge -> cmp_set env "ge"
  | Eq -> cmp_set env "eq"
  | Ne -> cmp_set env "ne"

and cmp_set env cond =
  let () = emit env "\tcmp\tx1, x0" in
  let () = emit env "\tcset\tx0, %s" cond in
  Some ()

and gen_call env f args =
  let args = Array.of_list args in
  let n = Array.length args in
  let k = min n 8 in
  let nstack = n - k in
  let area = align16 (8 * nstack) in
  let () = if area > 0 then emit env "\tsub\tsp, sp, #%d" area in
  let rec push_args i =
    if i >= k then Some ()
    else
      let* () = gen_expr env args.(i) in
      let () = push env in
      push_args (i + 1)
  in
  let* () = push_args 0 in
  let rec stack_args i =
    if i >= n then Some ()
    else
      let* () = gen_expr env args.(i) in
      let () = emit env "\tstr\tx0, [sp, #%d]" (16 * k + 8 * (i - 8)) in
      stack_args (i + 1)
  in
  let* () = stack_args 8 in
  let () =
    for i = 0 to k - 1 do
      emit env "\tldr\tx%d, [sp, #%d]" i (16 * (k - 1 - i))
    done
  in
  let () = if k > 0 then emit env "\tadd\tsp, sp, #%d" (16 * k) in
  let () = emit env "\tbl\t%s" f in
  let () = if area > 0 then emit env "\tadd\tsp, sp, #%d" area in
  Some ()

let rec gen_stmt env s =
  match s with
  | Empty -> Some ()
  | Expr e -> gen_expr env e
  | Return e ->
    let* () = gen_expr env e in
    let () = emit env "\tb\t%s" env.ret_label in
    Some ()
  | Compound (_, ss) -> iter_opt (gen_stmt env) ss
  | If (cond, then_s, else_opt) ->
    let l_else = fresh_label env in
    let l_end = fresh_label env in
    let* () = gen_expr env cond in
    let () = emit env "\tcmp\tx0, #0" in
    let () = emit env "\tbeq\t%s" l_else in
    let* () = gen_stmt env then_s in
    let () = emit env "\tb\t%s" l_end in
    let () = emit env "%s:" l_else in
    let* () =
      match else_opt with
      | Some s -> gen_stmt env s
      | None -> Some ()
    in
    let () = emit env "%s:" l_end in
    Some ()
  | While (cond, body) ->
    let l_top = fresh_label env in
    let l_end = fresh_label env in
    let () = emit env "%s:" l_top in
    let* () = gen_expr env cond in
    let () = emit env "\tcmp\tx0, #0" in
    let () = emit env "\tbeq\t%s" l_end in
    let () = env.loops <- (l_end, l_top) :: env.loops in
    let* () = gen_stmt env body in
    let () = env.loops <- List.tl env.loops in
    let () = emit env "\tb\t%s" l_top in
    let () = emit env "%s:" l_end in
    Some ()
  | Break ->
    (match env.loops with
     | (brk, _) :: _ ->
       let () = emit env "\tb\t%s" brk in
       Some ()
     | [] -> fail "break outside of loop")
  | Continue ->
    (match env.loops with
     | (_, cont) :: _ ->
       let () = emit env "\tb\t%s" cont in
       Some ()
     | [] -> fail "continue outside of loop")

let gen_fun buf (f : fun_definition) =
  let env = {
    buf;
    offsets = Hashtbl.create 16;
    label_id = 0;
    prefix = f.f_name;
    ret_label = Printf.sprintf ".Lret_%s" f.f_name;
    loops = [];
  } in
  let frame = assign_offsets env f.f_params f.f_body in
  let () = emit env "\t.text" in
  let () = emit env "\t.global\t%s" f.f_name in
  let () = emit env "%s:" f.f_name in
  let () = emit env "\tstp\tx29, x30, [sp, #-16]!" in
  let () = emit env "\tmov\tx29, sp" in
  let () = if frame > 0 then emit env "\tsub\tsp, sp, #%d" frame in
  let store_param i p =
    if i < 8 then
      let* off = offset_of env p.p_name in
      let () = emit env "\tstr\tx%d, [x29, #%d]" i off in
      Some ()
    else Some ()
  in
  let* () = iteri_opt store_param f.f_params in
  let* () = gen_stmt env f.f_body in
  let () = emit env "\tmov\tx0, #0" in
  let () = emit env "%s:" env.ret_label in
  let () = emit env "\tmov\tsp, x29" in
  let () = emit env "\tldp\tx29, x30, [sp], #16" in
  let () = emit env "\tret" in
  Some ()

let gen_program (prog : program) : string option =
  let buf = Buffer.create 1024 in
  let gen_one (FunDef f) =
    let* () = gen_fun buf f in
    let () = Buffer.add_char buf '\n' in
    Some ()
  in
  let* () = iter_opt gen_one prog in
  Some (Buffer.contents buf)

