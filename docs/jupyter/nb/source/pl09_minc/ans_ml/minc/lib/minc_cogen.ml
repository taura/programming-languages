type reg_op = REG_OP of string
;;

type mem_op =
  MEM_OP_VAR of int                 (* pseudo register *)
| MEM_OP_ARG of int                 (* outgoing argument *)
| MEM_OP_PARAM of int               (* incoming argument *)
;;

type insn =
  INSN_CALL of string
| INSN_LD of (mem_op * reg_op)
| INSN_ST of (reg_op * mem_op)
| INSN_MOVE of (reg_op * reg_op)
| INSN_SET_CONST of (int64 * reg_op)
| INSN_BIN_OP of (string * reg_op * mem_op)
| INSN_DIV of (string * reg_op)
| INSN_CQTO
| INSN_UN_OP of (string * reg_op)
| INSN_JMP of string
| INSN_CMP of (string * reg_op * mem_op)
| INSN_CMP_CONST of (string * reg_op * int)
| INSN_SETC of (string * reg_op)
| INSN_BE of string
| INSN_BNE of string
| INSN_LABEL of string
;;

(* temporary registers *)
let rax = REG_OP("rax")
;;
let rdi = REG_OP("rdi")
;;
let rdx = REG_OP("rdx")
;;

(* environment *)
let env_lookup x env = List.assoc x env
;;
let env_add v o env = (v, o) :: env
;;
let rec env_extend decls env var_idx =
  match decls with
    [] -> (env, var_idx)
  | (texpr,var)::rest_decls ->
     let env' = (var, (texpr, MEM_OP_VAR(var_idx)))::env in
     env_extend rest_decls env' (var_idx + 1)
;;

let make_call f arg_vars = 
  let rec make_call_iter f arg_vars arg_idx =
    match arg_vars with
      [] -> [ INSN_CALL(f) ]
    | var::rest_vars ->
       INSN_LD(var, rax)
       :: INSN_ST(rax, MEM_OP_ARG(arg_idx))
       :: make_call_iter f rest_vars (arg_idx + 1)
  in make_call_iter f arg_vars 0
;;

let dump_params params =
  let rec dump_params_iter idx params =
    match params with
      [] -> []
    | _::rest_params ->
       INSN_LD(MEM_OP_PARAM(idx), rax)
       :: INSN_ST(rax, MEM_OP_VAR(idx))
       :: dump_params_iter (idx + 1) rest_params
  in dump_params_iter 0 params
;;

exception Lhs_not_lvalue of Minc_ast.expr
;;

type un_op_type =
  UN_OP_TYPE_PLUS
| UN_OP_TYPE_ARITH
| UN_OP_TYPE_NOT
;;

exception Un_op_string_wrong_op of string
;;

let un_op_type op =
  match op with
    "+" -> UN_OP_TYPE_ARITH
  | "-" -> UN_OP_TYPE_ARITH
  | "~" -> UN_OP_TYPE_ARITH
  | "!" -> UN_OP_TYPE_NOT
  | _   -> raise (Un_op_string_wrong_op(op))
;;
  
type bin_op_type =
  BIN_OP_TYPE_ASSIGN
| BIN_OP_TYPE_ARITH
| BIN_OP_TYPE_DIV
| BIN_OP_TYPE_CMP
;;

exception Bin_op_string_wrong_op of string
;;

let bin_op_type op =
  match op with
    "="  -> BIN_OP_TYPE_ASSIGN
  | "==" -> BIN_OP_TYPE_CMP
  | "!=" -> BIN_OP_TYPE_CMP
  | "<"  -> BIN_OP_TYPE_CMP
  | ">"  -> BIN_OP_TYPE_CMP
  | "<=" -> BIN_OP_TYPE_CMP
  | ">=" -> BIN_OP_TYPE_CMP
  | "+"  -> BIN_OP_TYPE_ARITH
  | "-"  -> BIN_OP_TYPE_ARITH
  | "*"  -> BIN_OP_TYPE_ARITH
  | "/"  -> BIN_OP_TYPE_DIV
  | "%"  -> BIN_OP_TYPE_DIV
  | "&"  -> BIN_OP_TYPE_ARITH
  | _    -> raise (Bin_op_string_wrong_op(op))
;;

let bin_op_string op = 
  match op with
    "==" -> "sete"
  | "!=" -> "setne"
  | "<"  -> "setl"
  | ">"  -> "setg"
  | "<=" -> "setle"
  | ">=" -> "setge"
  | "+"  -> "addq"
  | "-"  -> "subq"
  | "*"  -> "imulq"
  | "/"  -> "idivq"
  | "%"  -> "idivq"
  | "&"  -> "testq"
  | _    -> raise (Bin_op_string_wrong_op(op))
;;

let un_op_string op = 
  match op with
    "-" -> "negq"
  | "~" -> "bnot?" 
  | _ -> raise (Un_op_string_wrong_op(op))
;;

let map_concat f l =        (* (f l0) @ (f l1) @ ... @ (f ln1-)*)
  List.concat (List.map f l)
;;

exception Bin_op_type_div_wrong_op of string
;;
exception Wrong_num_operands_op of (string * Minc_ast.expr list)
;;
exception Wrong_fun_expr of (Minc_ast.expr * Minc_ast.expr list)
;;


(* code gen for expr in the environment env *)
let rec ast_to_asm_expr expr env var_idx =
  match expr with
    Minc_ast.ExprIntLiteral(n) ->
     ([ INSN_SET_CONST(n, rdx) ], rdx)
  | Minc_ast.ExprId(x) ->
     let _,ox = env_lookup x env in
     ([ INSN_LD(ox, rdx) ], rdx)
  | Minc_ast.ExprOp(op, [e0; e1]) ->
     (match bin_op_type op with
        (* v = e *)
        BIN_OP_TYPE_ASSIGN ->
         (match e0 with
            Minc_ast.ExprId(x) ->
             let _,ox = env_lookup x env in
             let insns,reg = ast_to_asm_expr e1 env var_idx in
             ((insns @ [ INSN_ST(reg, ox) ]), reg)
          | _ -> raise (Lhs_not_lvalue(e0)))
      | BIN_OP_TYPE_ARITH ->
         (* e0 + e1 etc. *)
         let insns1,reg1 = ast_to_asm_expr e1 env var_idx in
         let insns0,reg0 = ast_to_asm_expr e0 env (var_idx + 1) in
         let m = MEM_OP_VAR(var_idx) in
         ((insns1
           @ [ INSN_ST(reg1, m) ]
           @ insns0
           @ [ INSN_BIN_OP(op, reg0, m) ]), (* reg0 = reg0 op m *)
          reg0)
      | BIN_OP_TYPE_DIV ->
         (* e0 + e1 etc. *)
         let insns1,reg1 = ast_to_asm_expr e1 env var_idx in
         let insns0,reg0 = ast_to_asm_expr e0 env (var_idx + 1) in
         let m = MEM_OP_VAR(var_idx) in
         let dreg = (match op with
                       "/" -> rax
                     | "%" -> rdx
                     | _ -> raise (Bin_op_type_div_wrong_op(op))) in
         ((insns1
           @ [ INSN_ST(reg1, m) ]
           @ insns0
           @ [ INSN_MOVE(reg0, rax);
               INSN_CQTO;
               INSN_LD(m, rdi);
               INSN_DIV(op, rdi) ]), (* rax,rdx = rdx:rax divmod rdi *)
          dreg)
      | BIN_OP_TYPE_CMP ->
         (* e0 < e1 etc. *)
         let insns1,reg1 = ast_to_asm_expr e1 env var_idx in
         let insns0,reg0 = ast_to_asm_expr e0 env (var_idx + 1) in
         let m1 = MEM_OP_VAR(var_idx) in
         let m0 = MEM_OP_VAR(var_idx + 1) in
         ((insns1
           @ [ INSN_ST(reg1, m1) ]
           @ insns0
           @ [ INSN_ST(reg0, m0);
               INSN_SET_CONST(0L, rax);
               INSN_LD(m0, reg0);
               INSN_CMP(op, reg0, m1);
               INSN_SETC(op, rax);
          ]),
          rax))
  | Minc_ast.ExprOp(op, [e]) ->
     (match un_op_type op with
        (* +e *)
        UN_OP_TYPE_PLUS ->
         ast_to_asm_expr e env var_idx
      | UN_OP_TYPE_ARITH ->
         (* -e, ~e *)
         let insns,reg = ast_to_asm_expr e env var_idx in
         ((insns @ [ INSN_UN_OP(op, reg) ]), reg) (* reg = op reg *)
      | UN_OP_TYPE_NOT ->
         (* !e *)
         let insns,reg = ast_to_asm_expr e env var_idx in
         let m = MEM_OP_VAR(var_idx) in
         ((insns
           @ [ INSN_ST(reg, m);
               INSN_SET_CONST(0L, rax);
               INSN_LD(m, reg);
               INSN_BIN_OP("&", reg, m);
               INSN_SETC("==", rax) ]),
          rax))
  | Minc_ast.ExprOp(op, args) ->
     raise (Wrong_num_operands_op(op, args))
  | Minc_ast.ExprCall(ExprId(f), args) ->
     let insns,arg_vars = ast_to_asm_exprs args env var_idx in
     ((insns @ (make_call f arg_vars)), rax)
  | Minc_ast.ExprCall(f, args) ->
     raise (Wrong_fun_expr(f, args))
  | Minc_ast.ExprParen(e) ->
     ast_to_asm_expr e env var_idx
    
and ast_to_asm_exprs exprs env var_idx =
  match exprs with
    [] -> ([], [])
  | expr::rest_exprs ->
     let insns,reg = ast_to_asm_expr expr env var_idx in
     let rest_insns,rest_vars = ast_to_asm_exprs rest_exprs env (var_idx + 1) in
     let var = MEM_OP_VAR(var_idx) in
     ((insns @ [ INSN_ST(reg, var) ] @ rest_insns),
      var::rest_vars)

and ast_to_asm_stmt stmt env var_idx gen_label label_cont label_brk label_ret =
  match stmt with
    Minc_ast.StmtEmpty -> []
  | Minc_ast.StmtContinue ->
     [ INSN_JMP(label_cont) ]
  | Minc_ast.StmtBreak ->
     [ INSN_JMP(label_brk) ]
  | Minc_ast.StmtReturn(expr) ->
     let insns,reg = ast_to_asm_expr expr env var_idx in
     insns @ [ INSN_MOVE(reg, rax); INSN_JMP(label_ret) ]
  | Minc_ast.StmtExpr(e) ->
     let insns,_ = ast_to_asm_expr e env var_idx in
     insns
  | Minc_ast.StmtCompound(decls, stmts) ->
     let env',var_idx' = env_extend decls env var_idx in
     ast_to_asm_stmts stmts env' var_idx' gen_label label_cont label_brk label_ret
  | Minc_ast.StmtIf(cexpr, then_stmt, else_stmt) ->
     let cexpr_insns,cexpr_reg = ast_to_asm_expr cexpr env var_idx in
     let then_insns = ast_to_asm_stmt then_stmt env var_idx gen_label label_cont label_brk label_ret in
     let else_insns = match else_stmt with
         None -> []
       | Some(else_stmt) -> ast_to_asm_stmt else_stmt env var_idx gen_label label_cont label_brk label_ret in
     let label_else = gen_label "e" in
     let label_endif = gen_label "f" in
     cexpr_insns
     @ [ INSN_CMP_CONST("==", cexpr_reg, 0);
         INSN_BE(label_else) ]
     @ then_insns
     @ [ INSN_JMP(label_endif);
         INSN_LABEL(label_else) ]
     @ else_insns
     @ [ INSN_LABEL(label_endif) ]
  | Minc_ast.StmtWhile(cexpr, body_stmt) ->
     let label_cexpr = gen_label "w" in
     let label_exit  = gen_label "x" in
     let label_body  = gen_label "b" in
     let body_insns = ast_to_asm_stmt body_stmt env var_idx gen_label label_cexpr label_exit label_ret in
     let cexpr_insns,cexpr_reg = ast_to_asm_expr cexpr env var_idx in
     INSN_JMP(label_cexpr)
     :: INSN_LABEL(label_body)
     :: body_insns
     @ [ INSN_LABEL(label_cexpr) ]
     @ cexpr_insns
     @ [ INSN_CMP_CONST("==", cexpr_reg, 0) ]
     @ [ INSN_BNE(label_body) ]
     @ [ INSN_LABEL(label_exit) ]

and ast_to_asm_stmts stmts env var_idx gen_label label_cont label_brk label_ret =
  map_concat 
    (fun stmt ->
      ast_to_asm_stmt stmt env var_idx gen_label label_cont label_brk label_ret)
    stmts
;;

let reg_op_string (REG_OP(reg)) = Printf.sprintf "%%%s" reg
;;

exception Reg_op_string_low_wrong_register of string
;;

let reg_op_string_low (REG_OP(reg)) =
  if reg = "rax" then "%al"
  else raise (Reg_op_string_low_wrong_register(reg))
;;

let mem_op_string mem n_args n_params n_slots =
  let sp = Printf.sprintf in
  let arg_regs = [ "%rdi"; "%rsi"; "%rdx"; "%rcx"; "%r8"; "%r9" ]  in
  match mem with
    MEM_OP_ARG(i)   ->
     if i < 6 then
       List.nth arg_regs i
     else
       sp "%d(%%rsp)" (8 * (i - 6))
  | MEM_OP_VAR(i)   ->
     if n_args < 6 then
       sp "%d(%%rsp)" (8 * i)
     else
       sp "%d(%%rsp)" (8 * (i + n_args - 6))
  | MEM_OP_PARAM(i) ->
     if i < 6 then
       List.nth arg_regs i
     else if n_params < 6 then
       sp "%d(%%rsp)" (8 * (i + n_slots))
     else
       sp "%d(%%rsp)" (8 * (i + n_slots - 6))
;;

let insn_to_asm insn n_args n_params n_slots =
  let sp = Printf.sprintf in
  let ms mem = mem_op_string mem n_args n_params n_slots in
  let rs = reg_op_string in
  let rsl = reg_op_string_low in
  let bs = bin_op_string in
  let us = un_op_string in
  match insn with
    INSN_CALL(f)               -> (sp "\tcall %s" f)
  | INSN_LD(mem, reg)          -> (sp "\tmovq %s,%s" (ms mem) (rs reg))
  | INSN_ST(reg, mem)          -> (sp "\tmovq %s,%s" (rs reg) (ms mem))
  | INSN_MOVE(reg0, reg1)      -> (sp "\tmovq %s,%s" (rs reg0) (rs reg1))
  | INSN_SET_CONST(n, reg)     -> (sp "\tmovq $%Ld,%s" n (rs reg))
  | INSN_BIN_OP(op, reg, mem)  -> (sp "\t%s %s,%s" (bs op) (ms mem) (rs reg))
  | INSN_DIV(op, reg)          -> (sp "\t%s %s" (bs op) (rs reg))
  | INSN_CQTO                  -> (sp "\tcqto")
  | INSN_UN_OP(op, reg)        -> (sp "\t%s %s" (us op) (rs reg))
  | INSN_JMP(l)                -> (sp "\tjmp %s" l)
  | INSN_CMP(_, reg, mem)      -> (sp "\tcmpq %s,%s" (ms mem) (rs reg))
  | INSN_CMP_CONST(_, reg, n)  -> (sp "\tcmpq $%d,%s" n (rs reg))
  | INSN_SETC(op, reg)         -> (sp "\t%s %s" (bs op) (rsl reg))
  | INSN_BE(l)                 -> (sp "\tje %s" l)
  | INSN_BNE(l)                -> (sp "\tjne %s" l)
  | INSN_LABEL(l)              -> (sp "%s:" l)
;;

let insns_to_asm insns n_args n_params n_slots =
  String.concat "\n"
    (List.map (fun insn -> insn_to_asm insn n_args n_params n_slots) insns)
;;  

let mem_op_var_idx mem =
  match mem with
    MEM_OP_VAR(i)    -> i
   | MEM_OP_PARAM(_) -> -1
   | MEM_OP_ARG(_)   -> -1
;;
let mem_op_arg_idx mem =
  match mem with
    MEM_OP_VAR(_)    -> -1
   | MEM_OP_PARAM(_) -> -1
   | MEM_OP_ARG(i)   -> i
;;

let insn_var_idx insn =
  match insn with
    INSN_CALL(_)                -> -1
  | INSN_LD(MEM_OP_VAR(i), _)   -> i
  | INSN_LD(MEM_OP_PARAM(_), _) -> -1
  | INSN_LD(MEM_OP_ARG(_), _)   -> -1
  | INSN_ST(_, mem)             -> mem_op_var_idx mem
  | INSN_MOVE(_, _)             -> -1
  | INSN_SET_CONST(_, _)        -> -1
  | INSN_BIN_OP(_, _, mem)      -> mem_op_var_idx mem
  | INSN_DIV(_, _)              -> -1
  | INSN_CQTO                   -> -1
  | INSN_UN_OP(_, _)            -> -1
  | INSN_JMP(_)                 -> -1
  | INSN_CMP(_, _, mem)         -> mem_op_var_idx mem
  | INSN_CMP_CONST(_, _, _)     -> -1
  | INSN_SETC(_, _)             -> -1
  | INSN_BE(_)                  -> -1
  | INSN_BNE(_)                 -> -1
  | INSN_LABEL(_)               -> -1
;;

let insn_arg_idx ins =
  match ins with
    INSN_CALL(_)                -> -1
  | INSN_LD(MEM_OP_VAR(_), _)   -> -1
  | INSN_LD(MEM_OP_PARAM(_), _) -> -1
  | INSN_LD(MEM_OP_ARG(i), _)   -> i
  | INSN_ST(_, mem)             -> mem_op_arg_idx mem
  | INSN_MOVE(_, _)             -> -1
  | INSN_SET_CONST(_, _)        -> -1
  | INSN_BIN_OP(_, _, mem)      -> mem_op_arg_idx mem
  | INSN_DIV(_, _)              -> -1
  | INSN_CQTO                   -> -1
  | INSN_UN_OP(_, _)            -> -1
  | INSN_JMP(_)                 -> -1
  | INSN_CMP(_, _, mem)         -> mem_op_arg_idx mem
  | INSN_CMP_CONST(_, _, _)     -> -1
  | INSN_SETC(_, _)             -> -1
  | INSN_BE(_)                  -> -1
  | INSN_BNE(_)                 -> -1
  | INSN_LABEL(_)               -> -1
;;

let rec max_list d l =
  match l with
    [] -> d
  | x::r ->
     if x > d then
       max_list x r
     else
       max_list d r
;;

let num_args insns =
  (max_list (-1) (List.map insn_arg_idx insns)) + 1
;;     

let num_locals insns =
  (max_list (-1) (List.map insn_var_idx insns)) + 1
;;     

let align2 x =
  (x + 1) - (x + 1) mod 2
;;

let prologue_asm f sp_extend =
  Printf.sprintf ".p2align 4,,15
	.globl	%s
	.type	%s, @function
%s:
\tsubq $%d,%%rsp
" f f f sp_extend
;;
let epilogue_asm f sp_extend =
  Printf.sprintf "\taddq $%d,%%rsp
\tret
.size %s, .-%s
" sp_extend f f
;;

let ast_to_asm_def (Minc_ast.DefFun(f, params, _ret_type, body)) gen_label =
  let env,var_idx = env_extend params [] 0 in
  let label_ret = gen_label "r" in
  let insns = dump_params params
              @ ast_to_asm_stmt body env var_idx gen_label "" "" label_ret
              @ [ INSN_LABEL(label_ret) ] in
  let n_params = (List.length params) in
  let n_args = num_args insns in
  let n_locals = num_locals insns in
  (* slots for spilled outgoing args *)
  let n_args_spilled = if n_args <= 6 then 0 else n_args - 6 in
  (* slots for spilled outgoing args + local vars *)
  let n_args_spilled_locals = n_args_spilled + n_locals in
  (* slots for spilled outgoing args + local vars + return addr *)
  let n_args_spilled_locals_ra = n_args_spilled_locals + 1 in
  (* align it to 16 bytes *)
  let n_total_slots = align2 n_args_spilled_locals_ra in
  (* extend stack by this amount *)
  let stack_extend = (n_total_slots - 1) * 8 in
  (prologue_asm f stack_extend)
  ^ (insns_to_asm insns n_args n_params n_total_slots) ^ "\n"
  ^ (epilogue_asm f stack_extend)
;;


let ast_to_asm_program (Minc_ast.Program(defs)) =
  let x = ref 0 in
  let inc () = let r = !x in x := !x + 1; r in
  let gen_label s = Printf.sprintf ".L%s%d" s (inc ()) in 
  String.concat ""
    ((List.map (fun def -> ast_to_asm_def def gen_label) defs)
     @ [ ".section	.note.GNU-stack,\"\",@progbits\n" ])


;;
