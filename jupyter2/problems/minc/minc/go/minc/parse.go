package main

import "fmt"

type ParseError struct{ Msg string }

func (e *ParseError) Error() string { return "parse error: " + e.Msg }

type parser struct {
	toks []Token
	pos  int
}

func (p *parser) peek() Token { return p.toks[p.pos] }

func (p *parser) advance() Token {
	t := p.toks[p.pos]
	if p.pos < len(p.toks)-1 {
		p.pos++
	}
	return t
}

func (p *parser) expect(k TokKind) {
	t := p.peek()
	if t.Kind != k {
		panic(&ParseError{fmt.Sprintf("expected %s but got %s", Token{Kind: k}, t)})
	}
	p.advance()
}

// expr = equality_expr "=" expr | equality_expr
func (p *parser) parseExpr() Expr {
	lhs := p.parseEquality()
	if p.peek().Kind == TAssign {
		p.advance()
		return &Assign{LHS: lhs, RHS: p.parseExpr()}
	}
	return lhs
}

// equality_expr = cmp_expr { ("=="|"!=") cmp_expr }*
func (p *parser) parseEquality() Expr {
	lhs := p.parseCmp()
	for {
		switch p.peek().Kind {
		case TEq:
			p.advance()
			lhs = &Binary{OpEq, lhs, p.parseCmp()}
		case TNe:
			p.advance()
			lhs = &Binary{OpNe, lhs, p.parseCmp()}
		default:
			return lhs
		}
	}
}

// cmp_expr = additive_expr { ("<="|">="|"<"|">") additive_expr }*
func (p *parser) parseCmp() Expr {
	lhs := p.parseAdditive()
	for {
		var op BinaryOp
		switch p.peek().Kind {
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
		p.advance()
		lhs = &Binary{op, lhs, p.parseAdditive()}
	}
}

// additive_expr = multiplicative_expr { ("+"|"-") multiplicative_expr }*
func (p *parser) parseAdditive() Expr {
	lhs := p.parseMul()
	for {
		var op BinaryOp
		switch p.peek().Kind {
		case TPlus:
			op = OpAdd
		case TMinus:
			op = OpSub
		default:
			return lhs
		}
		p.advance()
		lhs = &Binary{op, lhs, p.parseMul()}
	}
}

// multiplicative_expr = unary_expr { ("*"|"/"|"%") unary_expr }*
func (p *parser) parseMul() Expr {
	lhs := p.parseUnary()
	for {
		var op BinaryOp
		switch p.peek().Kind {
		case TStar:
			op = OpMul
		case TSlash:
			op = OpDiv
		case TPercent:
			op = OpMod
		default:
			return lhs
		}
		p.advance()
		lhs = &Binary{op, lhs, p.parseUnary()}
	}
}

// unary_expr = number | identifier "(" arg_list ")" | identifier | "(" expr ")" | ("+"|"-"|"!"|"~") unary_expr
func (p *parser) parseUnary() Expr {
	t := p.peek()
	switch t.Kind {
	case TNum:
		p.advance()
		return &IntLit{t.Num}
	case TPlus:
		p.advance()
		return &Unary{OpPos, p.parseUnary()}
	case TMinus:
		p.advance()
		return &Unary{OpNeg, p.parseUnary()}
	case TNot:
		p.advance()
		return &Unary{OpLNot, p.parseUnary()}
	case TTilde:
		p.advance()
		return &Unary{OpBNot, p.parseUnary()}
	case TLParen:
		p.advance()
		e := p.parseExpr()
		p.expect(TRParen)
		return e
	case TId:
		p.advance()
		if p.peek().Kind == TLParen {
			p.advance()
			args := p.parseArgList()
			p.expect(TRParen)
			return &Call{Name: t.Str, Args: args}
		}
		return &VarRef{t.Str}
	default:
		panic(&ParseError{fmt.Sprintf("unexpected token %s in expression", t)})
	}
}

// arg_list = [ expr { "," expr }* ]
func (p *parser) parseArgList() []Expr {
	if p.peek().Kind == TRParen {
		return nil
	}
	args := []Expr{p.parseExpr()}
	for p.peek().Kind == TComma {
		p.advance()
		args = append(args, p.parseExpr())
	}
	return args
}

// type_expr = "long"
func (p *parser) parseType() TypeExpr {
	p.expect(TLong)
	return TyLong
}

func (p *parser) parseIdent() string {
	t := p.advance()
	if t.Kind != TId {
		panic(&ParseError{fmt.Sprintf("expected identifier but got %s", t)})
	}
	return t.Str
}

// stmt = ";" | "continue" ";" | "break" ";" | "return" expr ";" | compound_stmt | if_stmt | while_stmt | expr ";"
func (p *parser) parseStmt() Stmt {
	switch p.peek().Kind {
	case TSemi:
		p.advance()
		return &EmptyStmt{}
	case TContinue:
		p.advance()
		p.expect(TSemi)
		return &ContinueStmt{}
	case TBreak:
		p.advance()
		p.expect(TSemi)
		return &BreakStmt{}
	case TReturn:
		p.advance()
		e := p.parseExpr()
		p.expect(TSemi)
		return &ReturnStmt{e}
	case TLBrace:
		return p.parseCompound()
	case TIf:
		return p.parseIf()
	default:
		e := p.parseExpr()
		p.expect(TSemi)
		return &ExprStmt{e}
	}
}

// compound_stmt = "{" {var_decl}* {stmt}* "}"
func (p *parser) parseCompound() *Compound {
	p.expect(TLBrace)
	var decls []VarDecl
	for p.peek().Kind == TLong {
		ty := p.parseType()
		name := p.parseIdent()
		p.expect(TSemi)
		decls = append(decls, VarDecl{ty, name})
	}
	var stmts []Stmt
	for p.peek().Kind != TRBrace {
		stmts = append(stmts, p.parseStmt())
	}
	p.expect(TRBrace)
	return &Compound{Decls: decls, Stmts: stmts}
}

// if_stmt = "if" "(" expr ")" stmt [ "else" stmt ]
func (p *parser) parseIf() Stmt {
	p.expect(TIf)
	p.expect(TLParen)
	cond := p.parseExpr()
	p.expect(TRParen)
	then := p.parseStmt()
	var els Stmt
	if p.peek().Kind == TElse {
		p.advance()
		els = p.parseStmt()
	}
	return &IfStmt{Cond: cond, Then: then, Else: els}
}


// parameter = type_expr identifier
func (p *parser) parseParam() Param {
	ty := p.parseType()
	return Param{Type: ty, Name: p.parseIdent()}
}

// parameter_list = [ parameter { "," parameter }* ]
func (p *parser) parseParamList() []Param {
	if p.peek().Kind == TRParen {
		return nil
	}
	params := []Param{p.parseParam()}
	for p.peek().Kind == TComma {
		p.advance()
		params = append(params, p.parseParam())
	}
	return params
}

// fun_definition = type_expr identifier "(" parameter_list ")" compound_stmt
func (p *parser) parseFunDef() *FunDef {
	ret := p.parseType()
	name := p.parseIdent()
	p.expect(TLParen)
	params := p.parseParamList()
	p.expect(TRParen)
	body := p.parseCompound()
	return &FunDef{RetType: ret, Name: name, Params: params, Body: body}
}

// program = {definition}*
func (p *parser) parseProgram() *Program {
	var funcs []*FunDef
	for p.peek().Kind != TEOF {
		funcs = append(funcs, p.parseFunDef())
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
	p := &parser{toks: toks}
	prog = p.parseProgram()
	if p.peek().Kind != TEOF {
		panic(&ParseError{fmt.Sprintf("trailing tokens, starting at %s", p.peek())})
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
