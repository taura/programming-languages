open Ast

let ( let* ) = Option.bind

(* report an error at the point it occurs and return None *)
let fail msg =
  let () = Printf.eprintf "parse error: %s\n" msg in
  None

type token_stream = {
  toks : Lex.token array;
  mutable pos : int;
}

let mk toks = { toks = Array.of_list toks; pos = 0 }

let peek tk = tk.toks.(tk.pos)

let advance tk =
  let t = tk.toks.(tk.pos) in
  if tk.pos < Array.length tk.toks - 1 then tk.pos <- tk.pos + 1;
  t

let expect tk tok =
  let t = peek tk in
  if t = tok then
    let _ = advance tk in
    Some ()
  else
    fail (Printf.sprintf "expected %s but got %s"
            (Lex.to_string tok) (Lex.to_string t))

(* expr = equality_expr "=" expr | equality_expr *)
let rec parse_expr tk =
  let* lhs = parse_equality tk in
  match peek tk with
  | Lex.ASSIGN ->
    let _ = advance tk in
    let* rhs = parse_expr tk in
    Some (Assign (lhs, rhs))
  | _ -> Some lhs

(* equality_expr = cmp_expr { ("=="|"!=") cmp_expr }* *)
and parse_equality tk =
  let rec loop lhs =
    match peek tk with
    | Lex.EQ ->
      let _ = advance tk in
      let* rhs = parse_cmp tk in
      loop (Binary (Eq, lhs, rhs))
    | Lex.NE ->
      let _ = advance tk in
      let* rhs = parse_cmp tk in
      loop (Binary (Ne, lhs, rhs))
    | _ -> Some lhs
  in
  let* first = parse_cmp tk in
  loop first

(* cmp_expr = additive_expr { ("<="|">="|"<"|">") additive_expr }* *)
and parse_cmp tk =
  let rec loop lhs =
    match peek tk with
    | Lex.LT ->
      let _ = advance tk in
      let* rhs = parse_additive tk in
      loop (Binary (Lt, lhs, rhs))
    | Lex.GT ->
      let _ = advance tk in
      let* rhs = parse_additive tk in
      loop (Binary (Gt, lhs, rhs))
    | Lex.LE ->
      let _ = advance tk in
      let* rhs = parse_additive tk in
      loop (Binary (Le, lhs, rhs))
    | Lex.GE ->
      let _ = advance tk in
      let* rhs = parse_additive tk in
      loop (Binary (Ge, lhs, rhs))
    | _ -> Some lhs
  in
  let* first = parse_additive tk in
  loop first

(* additive_expr = multiplicative_expr { ("+"|"-") multiplicative_expr }* *)
and parse_additive tk =
  let rec loop lhs =
    match peek tk with
    | Lex.PLUS ->
      let _ = advance tk in
      let* rhs = parse_mul tk in
      loop (Binary (Add, lhs, rhs))
    | Lex.MINUS ->
      let _ = advance tk in
      let* rhs = parse_mul tk in
      loop (Binary (Sub, lhs, rhs))
    | _ -> Some lhs
  in
  let* first = parse_mul tk in
  loop first

(* multiplicative_expr = unary_expr { ("*"|"/"|"%") unary_expr }* *)
and parse_mul tk =
  let rec loop lhs =
    match peek tk with
    | Lex.STAR ->
      let _ = advance tk in
      let* rhs = parse_unary tk in
      loop (Binary (Mul, lhs, rhs))
    | Lex.SLASH ->
      let _ = advance tk in
      let* rhs = parse_unary tk in
      loop (Binary (Div, lhs, rhs))
    | Lex.PERCENT ->
      let _ = advance tk in
      let* rhs = parse_unary tk in
      loop (Binary (Mod, lhs, rhs))
    | _ -> Some lhs
  in
  let* first = parse_unary tk in
  loop first

(* unary_expr = number | identifier "(" arg_list ")" | identifier | "(" expr ")" | ("+"|"-"|"!"|"~") unary_expr *)
and parse_unary tk =
  match peek tk with
  | Lex.NUM n ->
    let _ = advance tk in
    Some (Int n)
  | Lex.PLUS ->
    let _ = advance tk in
    let* e = parse_unary tk in
    Some (Unary (Pos, e))
  | Lex.MINUS ->
    let _ = advance tk in
    let* e = parse_unary tk in
    Some (Unary (Neg, e))
  | Lex.NOT ->
    let _ = advance tk in
    let* e = parse_unary tk in
    Some (Unary (LNot, e))
  | Lex.TILDE ->
    let _ = advance tk in
    let* e = parse_unary tk in
    Some (Unary (BNot, e))
  | Lex.LPAREN ->
    let _ = advance tk in
    let* e = parse_expr tk in
    let* () = expect tk Lex.RPAREN in
    Some e
  | Lex.ID name ->
    let _ = advance tk in
    (match peek tk with
     | Lex.LPAREN ->
       let _ = advance tk in
       let* args = parse_arg_list tk in
       let* () = expect tk Lex.RPAREN in
       Some (Call (name, args))
     | _ -> Some (Var name))
  | t ->
    fail (Printf.sprintf "unexpected token %s in expression" (Lex.to_string t))

(* arg_list = expr { "," expr }* | {} *)
and parse_arg_list tk =
  match peek tk with
  | Lex.RPAREN -> Some []
  | _ ->
    let rec loop acc =
      let* e = parse_expr tk in
      match peek tk with
      | Lex.COMMA ->
        let _ = advance tk in
        loop (e :: acc)
      | _ -> Some (List.rev (e :: acc))
    in
    loop []

(* type_expr = "long" *)
let parse_type tk =
  let* () = expect tk Lex.LONG in
  Some TyLong

(* identifier *)
let parse_ident tk =
  match advance tk with
  | Lex.ID name -> Some name
  | t ->
    fail (Printf.sprintf "expected identifier but got %s" (Lex.to_string t))

(* stmt = ";" | "continue" ";" | "break" ";" | "return" expr ";" | compound_stmt | if_stmt | while_stmt | expr ";" *)
let rec parse_stmt tk =
  match peek tk with
  | Lex.SEMI ->
    let _ = advance tk in
    Some Empty
  | Lex.CONTINUE ->
    let _ = advance tk in
    let* () = expect tk Lex.SEMI in
    Some Continue
  | Lex.BREAK ->
    let _ = advance tk in
    let* () = expect tk Lex.SEMI in
    Some Break
  | Lex.RETURN ->
    let _ = advance tk in
    let* e = parse_expr tk in
    let* () = expect tk Lex.SEMI in
    Some (Return e)
  | Lex.LBRACE -> parse_compound tk
  | Lex.IF -> parse_if tk
  | _ ->
    let* e = parse_expr tk in
    let* () = expect tk Lex.SEMI in
    Some (Expr e)

(* compound_stmt = "{" {var_decl}* {stmt}* "}" *)
and parse_compound tk =
  let* () = expect tk Lex.LBRACE in
  let rec decls acc =
    match peek tk with
    | Lex.LONG ->
      let* ty = parse_type tk in
      let* name = parse_ident tk in
      let* () = expect tk Lex.SEMI in
      decls ({ vd_type = ty; vd_name = name } :: acc)
    | _ -> Some (List.rev acc)
  in
  let* ds = decls [] in
  let rec stmts acc =
    match peek tk with
    | Lex.RBRACE -> Some (List.rev acc)
    | _ ->
      let* s = parse_stmt tk in
      stmts (s :: acc)
  in
  let* ss = stmts [] in
  let* () = expect tk Lex.RBRACE in
  Some (Compound (ds, ss))

(* if_stmt = "if" "(" expr ")" stmt [ "else" stmt ] *)
and parse_if tk =
  let* () = expect tk Lex.IF in
  let* () = expect tk Lex.LPAREN in
  let* cond = parse_expr tk in
  let* () = expect tk Lex.RPAREN in
  let* then_s = parse_stmt tk in
  match peek tk with
  | Lex.ELSE ->
    let _ = advance tk in
    let* else_s = parse_stmt tk in
    Some (If (cond, then_s, Some else_s))
  | _ -> Some (If (cond, then_s, None))


(* parameter = type_expr identifier *)
let parse_param tk =
  let* ty = parse_type tk in
  let* name = parse_ident tk in
  Some { p_type = ty; p_name = name }

(* parameter_list = parameter { "," parameter }* | {} *)
let parse_param_list tk =
  match peek tk with
  | Lex.RPAREN -> Some []
  | _ ->
    let rec loop acc =
      let* p = parse_param tk in
      match peek tk with
      | Lex.COMMA ->
        let _ = advance tk in
        loop (p :: acc)
      | _ -> Some (List.rev (p :: acc))
    in
    loop []

(* fun_definition = type_expr identifier "(" parameter_list ")" compound_stmt *)
let parse_definition tk =
  let* ret = parse_type tk in
  let* name = parse_ident tk in
  let* () = expect tk Lex.LPAREN in
  let* params = parse_param_list tk in
  let* () = expect tk Lex.RPAREN in
  let* body = parse_compound tk in
  Some (FunDef { f_ret = ret; f_name = name; f_params = params; f_body = body })

(* program = {definition}* *)
let parse_program tk =
  let rec loop acc =
    match peek tk with
    | Lex.EOF -> Some (List.rev acc)
    | _ ->
      let* d = parse_definition tk in
      loop (d :: acc)
  in
  loop []

(* start = program $ *)
let parse (toks : Lex.token list) : program option =
  let tk = mk toks in
  let* prog = parse_program tk in
  match peek tk with
  | Lex.EOF -> Some prog
  | t ->
    fail (Printf.sprintf "trailing tokens, starting at %s" (Lex.to_string t))

let parse_string (s : string) : program option =
  let* toks = Lex.tokenize s in
  parse toks
