type token =
  | NUM of int
  | ID  of string
  | LONG
  | RETURN
  | IF
  | ELSE
  | BREAK
  | CONTINUE
  | LPAREN
  | RPAREN
  | LBRACE
  | RBRACE
  | COMMA
  | SEMI
  | ASSIGN
  | EQ
  | NE
  | LT
  | GT
  | LE
  | GE
  | PLUS
  | MINUS
  | STAR
  | SLASH
  | PERCENT
  | NOT
  | TILDE
  | EOF

let to_string = function
  | NUM n    -> Printf.sprintf "NUM(%d)" n
  | ID s     -> Printf.sprintf "ID(%s)" s
  | LONG     -> "long"
  | RETURN   -> "return"
  | IF       -> "if"
  | ELSE     -> "else"
  | BREAK    -> "break"
  | CONTINUE -> "continue"
  | LPAREN   -> "("
  | RPAREN   -> ")"
  | LBRACE   -> "{"
  | RBRACE   -> "}"
  | COMMA    -> ","
  | SEMI     -> ";"
  | ASSIGN   -> "="
  | EQ       -> "=="
  | NE       -> "!="
  | LT       -> "<"
  | GT       -> ">"
  | LE       -> "<="
  | GE       -> ">="
  | PLUS     -> "+"
  | MINUS    -> "-"
  | STAR     -> "*"
  | SLASH    -> "/"
  | PERCENT  -> "%"
  | NOT      -> "!"
  | TILDE    -> "~"
  | EOF      -> "<eof>"

(* report an error at the point it occurs and return None *)
let fail msg =
  let () = Printf.eprintf "lex error: %s\n" msg in
  None

let keyword = function
  | "long"     -> Some LONG
  | "return"   -> Some RETURN
  | "if"       -> Some IF
  | "else"     -> Some ELSE
  | "break"    -> Some BREAK
  | "continue" -> Some CONTINUE
  | _          -> None

let is_digit c = c >= '0' && c <= '9'
let is_alpha c =
  (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || c = '_'
let is_alnum c = is_alpha c || is_digit c
let is_space c = c = ' ' || c = '\t' || c = '\n' || c = '\r'

let tokenize (s : string) : token list option =
  let n = String.length s in
  let toks = ref [] in
  let emit t = toks := t :: !toks in
  let i = ref 0 in
  let error = ref None in
  let peek k = if !i + k < n then s.[!i + k] else '\000' in
  while !i < n && !error = None do
    let c = s.[!i] in
    if is_space c then
      incr i
    else if c = '/' && peek 1 = '/' then
      while !i < n && s.[!i] <> '\n' do incr i done
    else if c = '/' && peek 1 = '*' then begin
      i := !i + 2;
      while !i < n && not (s.[!i] = '*' && peek 1 = '/') do incr i done;
      if !i >= n then error := Some "unterminated block comment"
      else i := !i + 2
    end
    else if is_digit c then begin
      let start = !i in
      while !i < n && is_digit s.[!i] do incr i done;
      let lexeme = String.sub s start (!i - start) in
      emit (NUM (int_of_string lexeme))
    end
    else if is_alpha c then begin
      let start = !i in
      while !i < n && is_alnum s.[!i] do incr i done;
      let lexeme = String.sub s start (!i - start) in
      match keyword lexeme with
      | Some kw -> emit kw
      | None    -> emit (ID lexeme)
    end
    else
      match c, peek 1 with
      | '=', '=' ->
        let () = emit EQ in
        i := !i + 2
      | '!', '=' ->
        let () = emit NE in
        i := !i + 2
      | '<', '=' ->
        let () = emit LE in
        i := !i + 2
      | '>', '=' ->
        let () = emit GE in
        i := !i + 2
      | _ ->
        let single = match c with
          | '(' -> Some LPAREN | ')' -> Some RPAREN
          | '{' -> Some LBRACE | '}' -> Some RBRACE
          | ',' -> Some COMMA  | ';' -> Some SEMI
          | '=' -> Some ASSIGN | '<' -> Some LT | '>' -> Some GT
          | '+' -> Some PLUS   | '-' -> Some MINUS
          | '*' -> Some STAR   | '/' -> Some SLASH | '%' -> Some PERCENT
          | '!' -> Some NOT    | '~' -> Some TILDE
          | _   -> None
        in
        match single with
        | Some tok ->
          let () = emit tok in
          incr i
        | None ->
          error := Some (Printf.sprintf "unexpected character %C at offset %d" c !i)
  done;
  match !error with
  | Some msg -> fail msg
  | None     -> Some (List.rev (EOF :: !toks))
