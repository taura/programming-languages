(* open Minc_ast *)

(* this is what you should implement.
   it takes an AST of a program and converts it into
   an assembly string. it is called from main function. *)

exception NotImplemented of string
;;

let ast_to_asm_program _program =
  let asm = "this is an assembly code generated by minc compiler ...\n" in
  if true then
    raise (NotImplemented("YOU MUST IMPLEMENT ml/minc/lib/minc_cogen.ml:ast_to_asm_program"))
  else
    asm
;;
