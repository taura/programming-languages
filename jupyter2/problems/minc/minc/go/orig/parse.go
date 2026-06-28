package main

import "fmt"

type ParseError struct{ Msg string }

func (e *ParseError) Error() string { return "parse error: " + e.Msg }

type tokenStream struct {
	toks []Token
	pos  int
}

func peek(t *tokenStream) Token { return t.toks[t.pos] }

func advance(t *tokenStream) Token {
	tok := t.toks[t.pos]
	if t.pos < len(t.toks)-1 {
		t.pos++
	}
	return tok
}

func expect(t *tokenStream, k TokKind) {
	tok := peek(t)
	if tok.Kind != k {
		panic(&ParseError{fmt.Sprintf("expected %s but got %s", Token{Kind: k}, tok)})
	}
	advance(t)
}

// expr = equality_expr "=" expr | equality_expr
func parseExpr(t *tokenStream) Expr {
	lhs := parseEquality(t)
	if peek(t).Kind == TAssign {
		advance(t)
		return &Assign{LHS: lhs, RHS: parseExpr(t)}
	}
	return lhs
}

// equality_expr = cmp_expr { ("=="|"!=") cmp_expr }*
func parseEquality(t *tokenStream) Expr {
	lhs := parseCmp(t)
	for {
		switch peek(t).Kind {
		case TEq:
			advance(t)
			lhs = &Binary{OpEq, lhs, parseCmp(t)}
		case TNe:
			advance(t)
			lhs = &Binary{OpNe, lhs, parseCmp(t)}
		default:
			return lhs
		}
	}
}

// cmp_expr = additive_expr { ("<="|">="|"<"|">") additive_expr }*
func parseCmp(t *tokenStream) Expr {
	lhs := parseAdditive(t)
	for {
		var op BinaryOp
		switch peek(t).Kind {
		case TLt:
			op = OpLt
		case TGt:
			op = OpGt
		case TLe:
			op = OpLe
		case TGe:
			op = OpGe
		default:
			return lhs
		}
		advance(t)
		lhs = &Binary{op, lhs, parseAdditive(t)}
	}
}

// additive_expr = multiplicative_expr { ("+"|"-") multiplicative_expr }*
func parseAdditive(t *tokenStream) Expr {
	lhs := parseMul(t)
	for {
		var op BinaryOp
		switch peek(t).Kind {
		case TPlus:
			op = OpAdd
		case TMinus:
			op = OpSub
		default:
			return lhs
		}
		advance(t)
		lhs = &Binary{op, lhs, parseMul(t)}
	}
}

// multiplicative_expr = unary_expr { ("*"|"/"|"%") unary_expr }*
func parseMul(t *tokenStream) Expr {
	lhs := parseUnary(t)
	for {
		var op BinaryOp
		switch peek(t).Kind {
		case TStar:
			op = OpMul
		case TSlash:
			op = OpDiv
		case TPercent:
			op = OpMod
		default:
			return lhs
		}
		advance(t)
		lhs = &Binary{op, lhs, parseUnary(t)}
	}
}

// unary_expr = number | identifier "(" arg_list ")" | identifier | "(" expr ")" | ("+"|"-"|"!"|"~") unary_expr
func parseUnary(t *tokenStream) Expr {
	tok := peek(t)
	switch tok.Kind {
	case TNum:
		advance(t)
		return &IntLit{tok.Num}
	case TPlus:
		advance(t)
		return &Unary{OpPos, parseUnary(t)}
	case TMinus:
		advance(t)
		return &Unary{OpNeg, parseUnary(t)}
	case TNot:
		advance(t)
		return &Unary{OpLNot, parseUnary(t)}
	case TTilde:
		advance(t)
		return &Unary{OpBNot, parseUnary(t)}
	case TLParen:
		advance(t)
		e := parseExpr(t)
		expect(t, TRParen)
		return e
	case TId:
		advance(t)
		if peek(t).Kind == TLParen {
			advance(t)
			args := parseArgList(t)
			expect(t, TRParen)
			return &Call{Name: tok.Str, Args: args}
		}
		return &VarRef{tok.Str}
	default:
		panic(&ParseError{fmt.Sprintf("unexpected token %s in expression", tok)})
	}
}

// arg_list = [ expr { "," expr }* ]
func parseArgList(t *tokenStream) []Expr {
	if peek(t).Kind == TRParen {
		return nil
	}
	args := []Expr{parseExpr(t)}
	for peek(t).Kind == TComma {
		advance(t)
		args = append(args, parseExpr(t))
	}
	return args
}

// type_expr = "long"
func parseType(t *tokenStream) TypeExpr {
	expect(t, TLong)
	return TyLong
}

func parseIdent(t *tokenStream) string {
	tok := advance(t)
	if tok.Kind != TId {
		panic(&ParseError{fmt.Sprintf("expected identifier but got %s", tok)})
	}
	return tok.Str
}

// stmt = ";" | "continue" ";" | "break" ";" | "return" expr ";" | compound_stmt | if_stmt | while_stmt | expr ";"
func parseStmt(t *tokenStream) Stmt {
	switch peek(t).Kind {
	case TSemi:
		advance(t)
		return &EmptyStmt{}
	case TContinue:
		advance(t)
		expect(t, TSemi)
		return &ContinueStmt{}
	case TBreak:
		advance(t)
		expect(t, TSemi)
		return &BreakStmt{}
	case TReturn:
		advance(t)
		e := parseExpr(t)
		expect(t, TSemi)
		return &ReturnStmt{e}
	case TLBrace:
		return parseCompound(t)
	case TIf:
		return parseIf(t)
	default:
		e := parseExpr(t)
		expect(t, TSemi)
		return &ExprStmt{e}
	}
}

// compound_stmt = "{" {var_decl}* {stmt}* "}"
func parseCompound(t *tokenStream) *Compound {
	expect(t, TLBrace)
	var decls []VarDecl
	for peek(t).Kind == TLong {
		ty := parseType(t)
		name := parseIdent(t)
		expect(t, TSemi)
		decls = append(decls, VarDecl{ty, name})
	}
	var stmts []Stmt
	for peek(t).Kind != TRBrace {
		stmts = append(stmts, parseStmt(t))
	}
	expect(t, TRBrace)
	return &Compound{Decls: decls, Stmts: stmts}
}

// if_stmt = "if" "(" expr ")" stmt [ "else" stmt ]
func parseIf(t *tokenStream) Stmt {
	expect(t, TIf)
	expect(t, TLParen)
	cond := parseExpr(t)
	expect(t, TRParen)
	then := parseStmt(t)
	var els Stmt
	if peek(t).Kind == TElse {
		advance(t)
		els = parseStmt(t)
	}
	return &IfStmt{Cond: cond, Then: then, Else: els}
}


// parameter = type_expr identifier
func parseParam(t *tokenStream) Param {
	ty := parseType(t)
	return Param{Type: ty, Name: parseIdent(t)}
}

// parameter_list = [ parameter { "," parameter }* ]
func parseParamList(t *tokenStream) []Param {
	if peek(t).Kind == TRParen {
		return nil
	}
	params := []Param{parseParam(t)}
	for peek(t).Kind == TComma {
		advance(t)
		params = append(params, parseParam(t))
	}
	return params
}

// fun_definition = type_expr identifier "(" parameter_list ")" compound_stmt
func parseFunDef(t *tokenStream) *FunDef {
	ret := parseType(t)
	name := parseIdent(t)
	expect(t, TLParen)
	params := parseParamList(t)
	expect(t, TRParen)
	body := parseCompound(t)
	return &FunDef{RetType: ret, Name: name, Params: params, Body: body}
}

// program = {definition}*
func parseProgram(t *tokenStream) *Program {
	var funcs []*FunDef
	for peek(t).Kind != TEOF {
		funcs = append(funcs, parseFunDef(t))
	}
	return &Program{Funcs: funcs}
}

func Parse(toks []Token) (prog *Program, err error) {
	defer func() {
		if r := recover(); r != nil {
			if pe, ok := r.(*ParseError); ok {
				err = pe
				return
			}
			panic(r)
		}
	}()
	t := &tokenStream{toks: toks}
	prog = parseProgram(t)
	if peek(t).Kind != TEOF {
		panic(&ParseError{fmt.Sprintf("trailing tokens, starting at %s", peek(t))})
	}
	return prog, nil
}

func ParseString(s string) (*Program, error) {
	toks, err := Tokenize(s)
	if err != nil {
		return nil, err
	}
	return Parse(toks)
}
