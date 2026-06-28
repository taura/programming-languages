use crate::ast::*;
use crate::lex::{tokenize, Tok, tok_to_string};

pub struct TokenStream {
    toks: Vec<Tok>,
    pos: usize,
}

fn peek(t: &TokenStream) -> &Tok {
    &t.toks[t.pos]
}

fn advance(t: &mut TokenStream) -> Tok {
    let tok = t.toks[t.pos].clone();
    if t.pos < t.toks.len() - 1 {
        t.pos += 1;
    }
    tok
}

fn expect(t: &mut TokenStream, k: &Tok) -> Result<(), String> {
    let tok = peek(t);
    if tok != k {
        return Err(format!("parse error: expected {} but got {}", tok_to_string(k), tok_to_string(tok)));
    }
    advance(t);
    Ok(())
}

// expr = equality_expr "=" expr | equality_expr
fn parse_expr(t: &mut TokenStream) -> Result<Expr, String> {
    let lhs = parse_equality(t)?;
    if *peek(t) == Tok::Assign {
        advance(t);
        let rhs = parse_expr(t)?;
        return Ok(Expr::Assign(Box::new(lhs), Box::new(rhs)));
    }
    Ok(lhs)
}

// equality_expr = cmp_expr { ("=="|"!=") cmp_expr }*
fn parse_equality(t: &mut TokenStream) -> Result<Expr, String> {
    let mut lhs = parse_cmp(t)?;
    loop {
        let op = match peek(t) {
            Tok::Eq => BinaryOp::Eq,
            Tok::Ne => BinaryOp::Ne,
            _ => return Ok(lhs),
        };
        advance(t);
        let rhs = parse_cmp(t)?;
        lhs = Expr::Binary(op, Box::new(lhs), Box::new(rhs));
    }
}

// cmp_expr = additive_expr { ("<="|">="|"<"|">") additive_expr }*
fn parse_cmp(t: &mut TokenStream) -> Result<Expr, String> {
    let mut lhs = parse_additive(t)?;
    loop {
        let op = match peek(t) {
            Tok::Lt => BinaryOp::Lt,
            Tok::Gt => BinaryOp::Gt,
            Tok::Le => BinaryOp::Le,
            Tok::Ge => BinaryOp::Ge,
            _ => return Ok(lhs),
        };
        advance(t);
        let rhs = parse_additive(t)?;
        lhs = Expr::Binary(op, Box::new(lhs), Box::new(rhs));
    }
}

// additive_expr = multiplicative_expr { ("+"|"-") multiplicative_expr }*
fn parse_additive(t: &mut TokenStream) -> Result<Expr, String> {
    let mut lhs = parse_mul(t)?;
    loop {
        let op = match peek(t) {
            Tok::Plus => BinaryOp::Add,
            Tok::Minus => BinaryOp::Sub,
            _ => return Ok(lhs),
        };
        advance(t);
        let rhs = parse_mul(t)?;
        lhs = Expr::Binary(op, Box::new(lhs), Box::new(rhs));
    }
}

// multiplicative_expr = unary_expr { ("*"|"/"|"%") unary_expr }*
fn parse_mul(t: &mut TokenStream) -> Result<Expr, String> {
    let mut lhs = parse_unary(t)?;
    loop {
        let op = match peek(t) {
            Tok::Star => BinaryOp::Mul,
            Tok::Slash => BinaryOp::Div,
            Tok::Percent => BinaryOp::Mod,
            _ => return Ok(lhs),
        };
        advance(t);
        let rhs = parse_unary(t)?;
        lhs = Expr::Binary(op, Box::new(lhs), Box::new(rhs));
    }
}

// unary_expr = number | identifier "(" arg_list ")" | identifier | "(" expr ")" | ("+"|"-"|"!"|"~") unary_expr
fn parse_unary(t: &mut TokenStream) -> Result<Expr, String> {
    let tok = peek(t).clone();
    match tok {
        Tok::Num(v) => {
            advance(t);
            Ok(Expr::IntLit(v))
        }
        Tok::Plus => {
            advance(t);
            Ok(Expr::Unary(UnaryOp::Pos, Box::new(parse_unary(t)?)))
        }
        Tok::Minus => {
            advance(t);
            Ok(Expr::Unary(UnaryOp::Neg, Box::new(parse_unary(t)?)))
        }
        Tok::Not => {
            advance(t);
            Ok(Expr::Unary(UnaryOp::LNot, Box::new(parse_unary(t)?)))
        }
        Tok::Tilde => {
            advance(t);
            Ok(Expr::Unary(UnaryOp::BNot, Box::new(parse_unary(t)?)))
        }
        Tok::LParen => {
            advance(t);
            let e = parse_expr(t)?;
            expect(t, &Tok::RParen)?;
            Ok(e)
        }
        Tok::Id(name) => {
            advance(t);
            if *peek(t) == Tok::LParen {
                advance(t);
                let args = parse_arg_list(t)?;
                expect(t, &Tok::RParen)?;
                Ok(Expr::Call(name, args))
            } else {
                Ok(Expr::VarRef(name))
            }
        }
        _ => Err(format!("parse error: unexpected token {} in expression", tok_to_string(&tok))),
    }
}

// arg_list = [ expr { "," expr }* ]
fn parse_arg_list(t: &mut TokenStream) -> Result<Vec<Expr>, String> {
    if *peek(t) == Tok::RParen {
        return Ok(Vec::new());
    }
    let mut args = vec![parse_expr(t)?];
    while *peek(t) == Tok::Comma {
        advance(t);
        args.push(parse_expr(t)?);
    }
    Ok(args)
}

// type_expr = "long"
fn parse_type(t: &mut TokenStream) -> Result<TypeExpr, String> {
    expect(t, &Tok::Long)?;
    Ok(TypeExpr::Long)
}

fn parse_ident(t: &mut TokenStream) -> Result<String, String> {
    let tok = advance(t);
    match tok {
        Tok::Id(s) => Ok(s),
        _ => Err(format!("parse error: expected identifier but got {}", tok_to_string(&tok))),
    }
}

// stmt = ";" | "continue" ";" | "break" ";" | "return" expr ";" | compound_stmt | if_stmt | while_stmt | expr ";"
fn parse_stmt(t: &mut TokenStream) -> Result<Stmt, String> {
    match peek(t) {
        Tok::Semi => {
            advance(t);
            Ok(Stmt::Empty)
        }
        Tok::Continue => {
            advance(t);
            expect(t, &Tok::Semi)?;
            Ok(Stmt::Continue)
        }
        Tok::Break => {
            advance(t);
            expect(t, &Tok::Semi)?;
            Ok(Stmt::Break)
        }
        Tok::Return => {
            advance(t);
            let e = parse_expr(t)?;
            expect(t, &Tok::Semi)?;
            Ok(Stmt::Return(e))
        }
        Tok::LBrace => Ok(Stmt::Compound(parse_compound(t)?)),
        Tok::If => parse_if(t),
        _ => {
            let e = parse_expr(t)?;
            expect(t, &Tok::Semi)?;
            Ok(Stmt::ExprStmt(e))
        }
    }
}

// compound_stmt = "{" {var_decl}* {stmt}* "}"
fn parse_compound(t: &mut TokenStream) -> Result<Compound, String> {
    expect(t, &Tok::LBrace)?;
    let mut decls = Vec::new();
    while *peek(t) == Tok::Long {
        let ty = parse_type(t)?;
        let name = parse_ident(t)?;
        expect(t, &Tok::Semi)?;
        decls.push(VarDecl { ty, name });
    }
    let mut stmts = Vec::new();
    while *peek(t) != Tok::RBrace {
        stmts.push(parse_stmt(t)?);
    }
    expect(t, &Tok::RBrace)?;
    Ok(Compound { decls, stmts })
}

// if_stmt = "if" "(" expr ")" stmt [ "else" stmt ]
fn parse_if(t: &mut TokenStream) -> Result<Stmt, String> {
    expect(t, &Tok::If)?;
    expect(t, &Tok::LParen)?;
    let cond = parse_expr(t)?;
    expect(t, &Tok::RParen)?;
    let then = parse_stmt(t)?;
    let els = if *peek(t) == Tok::Else {
        advance(t);
        Some(Box::new(parse_stmt(t)?))
    } else {
        None
    };
    Ok(Stmt::If(cond, Box::new(then), els))
}


// parameter = type_expr identifier
fn parse_param(t: &mut TokenStream) -> Result<Param, String> {
    let ty = parse_type(t)?;
    let name = parse_ident(t)?;
    Ok(Param { ty, name })
}

// parameter_list = [ parameter { "," parameter }* ]
fn parse_param_list(t: &mut TokenStream) -> Result<Vec<Param>, String> {
    if *peek(t) == Tok::RParen {
        return Ok(Vec::new());
    }
    let mut params = vec![parse_param(t)?];
    while *peek(t) == Tok::Comma {
        advance(t);
        params.push(parse_param(t)?);
    }
    Ok(params)
}

// fun_definition = type_expr identifier "(" parameter_list ")" compound_stmt
fn parse_fun_def(t: &mut TokenStream) -> Result<FunDef, String> {
    let ret_type = parse_type(t)?;
    let name = parse_ident(t)?;
    expect(t, &Tok::LParen)?;
    let params = parse_param_list(t)?;
    expect(t, &Tok::RParen)?;
    let body = parse_compound(t)?;
    Ok(FunDef {
        ret_type,
        name,
        params,
        body,
    })
}

// program = {definition}* $
fn parse_program(t: &mut TokenStream) -> Result<Program, String> {
    let mut funcs = Vec::new();
    while *peek(t) != Tok::Eof {
        funcs.push(parse_fun_def(t)?);
    }
    Ok(Program { funcs })
}

pub fn parse(toks: Vec<Tok>) -> Result<Program, String> {
    let mut t = TokenStream { toks, pos: 0 };
    let prog = parse_program(&mut t)?;
    if *peek(&t) != Tok::Eof {
        return Err(format!(
            "parse error: trailing tokens, starting at {}",
            tok_to_string(peek(&t))
        ));
    }
    Ok(prog)
}

pub fn parse_string(s: &str) -> Result<Program, String> {
    let toks = tokenize(s)?;
    parse(toks)
}
