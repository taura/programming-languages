open Ast

let ( let* ) = Option.bind

(* report an error at the point it occurs and return None *)
let fail msg =
  let () = Printf.eprintf "parse error: %s\n" msg in
  None

type state = {
  toks : Lex.token array;
  mutable pos : int;
}

let mk toks = { toks = Array.of_list toks; pos = 0 }

let peek st = st.toks.(st.pos)

let advance st =
  let t = st.toks.(st.pos) in
  if st.pos < Array.length st.toks - 1 then st.pos <- st.pos + 1;
  t

let expect st tok =
  let t = peek st in
  if t = tok then
    let _ = advance st in
    Some ()
  else
    fail (Printf.sprintf "expected %s but got %s"
            (Lex.to_string tok) (Lex.to_string t))

(* expr = equality_expr "=" expr | equality_expr *)
let rec parse_expr st =
  let* lhs = parse_equality st in
  match peek st with
  | Lex.ASSIGN ->
    let _ = advance st in
    let* rhs = parse_expr st in
    Some (Assign (lhs, rhs))
  | _ -> Some lhs

(* equality_expr = cmp_expr { ("=="|"!=") cmp_expr }* *)
and parse_equality st =
  let rec loop lhs =
    match peek st with
    | Lex.EQ ->
      let _ = advance st in
      let* rhs = parse_cmp st in
      loop (Binary (Eq, lhs, rhs))
    | Lex.NE ->
      let _ = advance st in
      let* rhs = parse_cmp st in
      loop (Binary (Ne, lhs, rhs))
    | _ -> Some lhs
  in
  let* first = parse_cmp st in
  loop first

(* cmp_expr = additive_expr { ("<="|">="|"<"|">") additive_expr }* *)
and parse_cmp st =
  let rec loop lhs =
    match peek st with
    | Lex.LT ->
      let _ = advance st in
      let* rhs = parse_additive st in
      loop (Binary (Lt, lhs, rhs))
    | Lex.GT ->
      let _ = advance st in
      let* rhs = parse_additive st in
      loop (Binary (Gt, lhs, rhs))
    | Lex.LE ->
      let _ = advance st in
      let* rhs = parse_additive st in
      loop (Binary (Le, lhs, rhs))
    | Lex.GE ->
      let _ = advance st in
      let* rhs = parse_additive st in
      loop (Binary (Ge, lhs, rhs))
    | _ -> Some lhs
  in
  let* first = parse_additive st in
  loop first

(* additive_expr = multiplicative_expr { ("+"|"-") multiplicative_expr }* *)
and parse_additive st =
  let rec loop lhs =
    match peek st with
    | Lex.PLUS ->
      let _ = advance st in
      let* rhs = parse_mul st in
      loop (Binary (Add, lhs, rhs))
    | Lex.MINUS ->
      let _ = advance st in
      let* rhs = parse_mul st in
      loop (Binary (Sub, lhs, rhs))
    | _ -> Some lhs
  in
  let* first = parse_mul st in
  loop first

(* multiplicative_expr = unary_expr { ("*"|"/"|"%") unary_expr }* *)
and parse_mul st =
  let rec loop lhs =
    match peek st with
    | Lex.STAR ->
      let _ = advance st in
      let* rhs = parse_unary st in
      loop (Binary (Mul, lhs, rhs))
    | Lex.SLASH ->
      let _ = advance st in
      let* rhs = parse_unary st in
      loop (Binary (Div, lhs, rhs))
    | Lex.PERCENT ->
      let _ = advance st in
      let* rhs = parse_unary st in
      loop (Binary (Mod, lhs, rhs))
    | _ -> Some lhs
  in
  let* first = parse_unary st in
  loop first

(* unary_expr = number | identifier "(" arg_list ")" | identifier | "(" expr ")" | ("+"|"-"|"!"|"~") unary_expr *)
and parse_unary st =
  match peek st with
  | Lex.NUM n ->
    let _ = advance st in
    Some (Int n)
  | Lex.PLUS ->
    let _ = advance st in
    let* e = parse_unary st in
    Some (Unary (Pos, e))
  | Lex.MINUS ->
    let _ = advance st in
    let* e = parse_unary st in
    Some (Unary (Neg, e))
  | Lex.NOT ->
    let _ = advance st in
    let* e = parse_unary st in
    Some (Unary (LNot, e))
  | Lex.TILDE ->
    let _ = advance st in
    let* e = parse_unary st in
    Some (Unary (BNot, e))
  | Lex.LPAREN ->
    let _ = advance st in
    let* e = parse_expr st in
    let* () = expect st Lex.RPAREN in
    Some e
  | Lex.ID name ->
    let _ = advance st in
    (match peek st with
     | Lex.LPAREN ->
       let _ = advance st in
       let* args = parse_arg_list st in
       let* () = expect st Lex.RPAREN in
       Some (Call (name, args))
     | _ -> Some (Var name))
  | t ->
    fail (Printf.sprintf "unexpected token %s in expression" (Lex.to_string t))

(* arg_list = expr { "," expr }* | {} *)
and parse_arg_list st =
  match peek st with
  | Lex.RPAREN -> Some []
  | _ ->
    let rec loop acc =
      let* e = parse_expr st in
      match peek st with
      | Lex.COMMA ->
        let _ = advance st in
        loop (e :: acc)
      | _ -> Some (List.rev (e :: acc))
    in
    loop []

(* type_expr = "long" *)
let parse_type st =
  let* () = expect st Lex.LONG in
  Some TyLong

(* identifier *)
let parse_ident st =
  match advance st with
  | Lex.ID name -> Some name
  | t ->
    fail (Printf.sprintf "expected identifier but got %s" (Lex.to_string t))

(* stmt = ";" | "continue" ";" | "break" ";" | "return" expr ";" | compound_stmt | if_stmt | while_stmt | expr ";" *)
let rec parse_stmt st =
  match peek st with
  | Lex.SEMI ->
    let _ = advance st in
    Some Empty
  | Lex.CONTINUE ->
    let _ = advance st in
    let* () = expect st Lex.SEMI in
    Some Continue
  | Lex.BREAK ->
    let _ = advance st in
    let* () = expect st Lex.SEMI in
    Some Break
  | Lex.RETURN ->
    let _ = advance st in
    let* e = parse_expr st in
    let* () = expect st Lex.SEMI in
    Some (Return e)
  | Lex.LBRACE -> parse_compound st
  | Lex.IF -> parse_if st
  | _ ->
    let* e = parse_expr st in
    let* () = expect st Lex.SEMI in
    Some (Expr e)

(* compound_stmt = "{" {var_decl}* {stmt}* "}" *)
and parse_compound st =
  let* () = expect st Lex.LBRACE in
  let rec decls acc =
    match peek st with
    | Lex.LONG ->
      let* ty = parse_type st in
      let* name = parse_ident st in
      let* () = expect st Lex.SEMI in
      decls ({ vd_type = ty; vd_name = name } :: acc)
    | _ -> Some (List.rev acc)
  in
  let* ds = decls [] in
  let rec stmts acc =
    match peek st with
    | Lex.RBRACE -> Some (List.rev acc)
    | _ ->
      let* s = parse_stmt st in
      stmts (s :: acc)
  in
  let* ss = stmts [] in
  let* () = expect st Lex.RBRACE in
  Some (Compound (ds, ss))

(* if_stmt = "if" "(" expr ")" stmt [ "else" stmt ] *)
and parse_if st =
  let* () = expect st Lex.IF in
  let* () = expect st Lex.LPAREN in
  let* cond = parse_expr st in
  let* () = expect st Lex.RPAREN in
  let* then_s = parse_stmt st in
  match peek st with
  | Lex.ELSE ->
    let _ = advance st in
    let* else_s = parse_stmt st in
    Some (If (cond, then_s, Some else_s))
  | _ -> Some (If (cond, then_s, None))


(* parameter = type_expr identifier *)
let parse_param st =
  let* ty = parse_type st in
  let* name = parse_ident st in
  Some { p_type = ty; p_name = name }

(* parameter_list = parameter { "," parameter }* | {} *)
let parse_param_list st =
  match peek st with
  | Lex.RPAREN -> Some []
  | _ ->
    let rec loop acc =
      let* p = parse_param st in
      match peek st with
      | Lex.COMMA ->
        let _ = advance st in
        loop (p :: acc)
      | _ -> Some (List.rev (p :: acc))
    in
    loop []

(* fun_definition = type_expr identifier "(" parameter_list ")" compound_stmt *)
let parse_definition st =
  let* ret = parse_type st in
  let* name = parse_ident st in
  let* () = expect st Lex.LPAREN in
  let* params = parse_param_list st in
  let* () = expect st Lex.RPAREN in
  let* body = parse_compound st in
  Some (FunDef { f_ret = ret; f_name = name; f_params = params; f_body = body })

(* program = {definition}* *)
let parse_program st =
  let rec loop acc =
    match peek st with
    | Lex.EOF -> Some (List.rev acc)
    | _ ->
      let* d = parse_definition st in
      loop (d :: acc)
  in
  loop []

(* start = program $ *)
let parse (toks : Lex.token list) : program option =
  let st = mk toks in
  let* prog = parse_program st in
  match peek st with
  | Lex.EOF -> Some prog
  | t ->
    fail (Printf.sprintf "trailing tokens, starting at %s" (Lex.to_string t))

let parse_string (s : string) : program option =
  let* toks = Lex.tokenize s in
  parse toks
