(* type_expr = "long" *)
type type_expr =
  | TyLong

(* unary_op: ("+"|"-"|"!"|"~") unary_expr *)
type unary_op =
  | Pos    (* + *)
  | Neg    (* - *)
  | LNot   (* ! *)
  | BNot   (* ~ *)

(* binary_op *)
type binary_op =
  | Add | Sub             (* + - *)
  | Mul | Div | Mod       (* * / % *)
  | Lt | Gt | Le | Ge     (* < > <= >= *)
  | Eq | Ne               (* == != *)

(* expr *)
type expr =
  | Int    of int                  (* 123 *)
  | Var    of string               (* x *)
  | Call   of string * expr list   (* f(x, y) *)
  | Unary  of unary_op * expr      (* -x *)
  | Binary of binary_op * expr * expr  (* x + y *)
  | Assign of expr * expr          (* x = e *)

(* var_decl = "long" identifier ";" *)
type var_decl = {
  vd_type : type_expr;
  vd_name : string;
}

(* stmt *)
type stmt =
  | Empty                              (* ; *)
  | Continue                           (* continue; *)
  | Break                              (* break; *)
  | Return   of expr                   (* return e; *)
  | Compound of var_decl list * stmt list  (* { var_decl* stmt* } *)
  | If       of expr * stmt * stmt option  (* if (e) s [else s] *)
  | Expr     of expr                   (* e; *)

(* parameter = "long" identifier *)
type parameter = {
  p_type : type_expr;
  p_name : string;
}

(* fun_definition = "long" f "(" parameter_list ")" compound_stmt *)
type fun_definition = {
  f_ret    : type_expr;
  f_name   : string;
  f_params : parameter list;
  f_body   : stmt;
}

(* definition = fun_definition *)
type definition =
  | FunDef of fun_definition

(* program = {definition}* *)
type program = definition list
