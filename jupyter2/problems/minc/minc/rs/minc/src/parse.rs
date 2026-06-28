use crate::ast::*;
use crate::lex::{tokenize, Tok, tok_to_string};

pub struct Parser {
    toks: Vec<Tok>,
    pos: usize,
}

fn peek(p: &Parser) -> &Tok {
    &p.toks[p.pos]
}

fn advance(p: &mut Parser) -> Tok {
    let t = p.toks[p.pos].clone();
    if p.pos < p.toks.len() - 1 {
        p.pos += 1;
    }
    t
}

fn expect(p: &mut Parser, k: &Tok) -> Result<(), String> {
    let t = peek(p);
    if t != k {
        return Err(format!("parse error: expected {} but got {}", tok_to_string(k), tok_to_string(t)));
    }
    advance(p);
    Ok(())
}

// expr = equality_expr "=" expr | equality_expr
fn parse_expr(p: &mut Parser) -> Result<Expr, String> {
    let lhs = parse_equality(p)?;
    if *peek(p) == Tok::Assign {
        advance(p);
        let rhs = parse_expr(p)?;
        return Ok(Expr::Assign(Box::new(lhs), Box::new(rhs)));
    }
    Ok(lhs)
}

// equality_expr = cmp_expr { ("=="|"!=") cmp_expr }*
fn parse_equality(p: &mut Parser) -> Result<Expr, String> {
    let mut lhs = parse_cmp(p)?;
    loop {
        let op = match peek(p) {
            Tok::Eq => BinaryOp::Eq,
            Tok::Ne => BinaryOp::Ne,
            _ => return Ok(lhs),
        };
        advance(p);
        let rhs = parse_cmp(p)?;
        lhs = Expr::Binary(op, Box::new(lhs), Box::new(rhs));
    }
}

// cmp_expr = additive_expr { ("<="|">="|"<"|">") additive_expr }*
fn parse_cmp(p: &mut Parser) -> Result<Expr, String> {
    let mut lhs = parse_additive(p)?;
    loop {
        let op = match peek(p) {
            Tok::Lt => BinaryOp::Lt,
            Tok::Gt => BinaryOp::Gt,
            Tok::Le => BinaryOp::Le,
            Tok::Ge => BinaryOp::Ge,
            _ => return Ok(lhs),
        };
        advance(p);
        let rhs = parse_additive(p)?;
        lhs = Expr::Binary(op, Box::new(lhs), Box::new(rhs));
    }
}

// additive_expr = multiplicative_expr { ("+"|"-") multiplicative_expr }*
fn parse_additive(p: &mut Parser) -> Result<Expr, String> {
    let mut lhs = parse_mul(p)?;
    loop {
        let op = match peek(p) {
            Tok::Plus => BinaryOp::Add,
            Tok::Minus => BinaryOp::Sub,
            _ => return Ok(lhs),
        };
        advance(p);
        let rhs = parse_mul(p)?;
        lhs = Expr::Binary(op, Box::new(lhs), Box::new(rhs));
    }
}

// multiplicative_expr = unary_expr { ("*"|"/"|"%") unary_expr }*
fn parse_mul(p: &mut Parser) -> Result<Expr, String> {
    let mut lhs = parse_unary(p)?;
    loop {
        let op = match peek(p) {
            Tok::Star => BinaryOp::Mul,
            Tok::Slash => BinaryOp::Div,
            Tok::Percent => BinaryOp::Mod,
            _ => return Ok(lhs),
        };
        advance(p);
        let rhs = parse_unary(p)?;
        lhs = Expr::Binary(op, Box::new(lhs), Box::new(rhs));
    }
}

// unary_expr = number | identifier "(" arg_list ")" | identifier | "(" expr ")" | ("+"|"-"|"!"|"~") unary_expr
fn parse_unary(p: &mut Parser) -> Result<Expr, String> {
    let t = peek(p).clone();
    match t {
        Tok::Num(v) => {
            advance(p);
            Ok(Expr::IntLit(v))
        }
        Tok::Plus => {
            advance(p);
            Ok(Expr::Unary(UnaryOp::Pos, Box::new(parse_unary(p)?)))
        }
        Tok::Minus => {
            advance(p);
            Ok(Expr::Unary(UnaryOp::Neg, Box::new(parse_unary(p)?)))
        }
        Tok::Not => {
            advance(p);
            Ok(Expr::Unary(UnaryOp::LNot, Box::new(parse_unary(p)?)))
        }
        Tok::Tilde => {
            advance(p);
            Ok(Expr::Unary(UnaryOp::BNot, Box::new(parse_unary(p)?)))
        }
        Tok::LParen => {
            advance(p);
            let e = parse_expr(p)?;
            expect(p, &Tok::RParen)?;
            Ok(e)
        }
        Tok::Id(name) => {
            advance(p);
            if *peek(p) == Tok::LParen {
                advance(p);
                let args = parse_arg_list(p)?;
                expect(p, &Tok::RParen)?;
                Ok(Expr::Call(name, args))
            } else {
                Ok(Expr::VarRef(name))
            }
        }
        _ => Err(format!("parse error: unexpected token {} in expression", tok_to_string(&t))),
    }
}

// arg_list = [ expr { "," expr }* ]
fn parse_arg_list(p: &mut Parser) -> Result<Vec<Expr>, String> {
    if *peek(p) == Tok::RParen {
        return Ok(Vec::new());
    }
    let mut args = vec![parse_expr(p)?];
    while *peek(p) == Tok::Comma {
        advance(p);
        args.push(parse_expr(p)?);
    }
    Ok(args)
}

// type_expr = "long"
fn parse_type(p: &mut Parser) -> Result<TypeExpr, String> {
    expect(p, &Tok::Long)?;
    Ok(TypeExpr::Long)
}

fn parse_ident(p: &mut Parser) -> Result<String, String> {
    let t = advance(p);
    match t {
        Tok::Id(s) => Ok(s),
        _ => Err(format!("parse error: expected identifier but got {}", tok_to_string(&t))),
    }
}

// stmt = ";" | "continue" ";" | "break" ";" | "return" expr ";" | compound_stmt | if_stmt | while_stmt | expr ";"
fn parse_stmt(p: &mut Parser) -> Result<Stmt, String> {
    match peek(p) {
        Tok::Semi => {
            advance(p);
            Ok(Stmt::Empty)
        }
        Tok::Continue => {
            advance(p);
            expect(p, &Tok::Semi)?;
            Ok(Stmt::Continue)
        }
        Tok::Break => {
            advance(p);
            expect(p, &Tok::Semi)?;
            Ok(Stmt::Break)
        }
        Tok::Return => {
            advance(p);
            let e = parse_expr(p)?;
            expect(p, &Tok::Semi)?;
            Ok(Stmt::Return(e))
        }
        Tok::LBrace => Ok(Stmt::Compound(parse_compound(p)?)),
        Tok::If => parse_if(p),
        _ => {
            let e = parse_expr(p)?;
            expect(p, &Tok::Semi)?;
            Ok(Stmt::ExprStmt(e))
        }
    }
}

// compound_stmt = "{" {var_decl}* {stmt}* "}"
fn parse_compound(p: &mut Parser) -> Result<Compound, String> {
    expect(p, &Tok::LBrace)?;
    let mut decls = Vec::new();
    while *peek(p) == Tok::Long {
        let ty = parse_type(p)?;
        let name = parse_ident(p)?;
        expect(p, &Tok::Semi)?;
        decls.push(VarDecl { ty, name });
    }
    let mut stmts = Vec::new();
    while *peek(p) != Tok::RBrace {
        stmts.push(parse_stmt(p)?);
    }
    expect(p, &Tok::RBrace)?;
    Ok(Compound { decls, stmts })
}

// if_stmt = "if" "(" expr ")" stmt [ "else" stmt ]
fn parse_if(p: &mut Parser) -> Result<Stmt, String> {
    expect(p, &Tok::If)?;
    expect(p, &Tok::LParen)?;
    let cond = parse_expr(p)?;
    expect(p, &Tok::RParen)?;
    let then = parse_stmt(p)?;
    let els = if *peek(p) == Tok::Else {
        advance(p);
        Some(Box::new(parse_stmt(p)?))
    } else {
        None
    };
    Ok(Stmt::If(cond, Box::new(then), els))
}


// parameter = type_expr identifier
fn parse_param(p: &mut Parser) -> Result<Param, String> {
    let ty = parse_type(p)?;
    let name = parse_ident(p)?;
    Ok(Param { ty, name })
}

// parameter_list = [ parameter { "," parameter }* ]
fn parse_param_list(p: &mut Parser) -> Result<Vec<Param>, String> {
    if *peek(p) == Tok::RParen {
        return Ok(Vec::new());
    }
    let mut params = vec![parse_param(p)?];
    while *peek(p) == Tok::Comma {
        advance(p);
        params.push(parse_param(p)?);
    }
    Ok(params)
}

// fun_definition = type_expr identifier "(" parameter_list ")" compound_stmt
fn parse_fun_def(p: &mut Parser) -> Result<FunDef, String> {
    let ret_type = parse_type(p)?;
    let name = parse_ident(p)?;
    expect(p, &Tok::LParen)?;
    let params = parse_param_list(p)?;
    expect(p, &Tok::RParen)?;
    let body = parse_compound(p)?;
    Ok(FunDef {
        ret_type,
        name,
        params,
        body,
    })
}

// program = {definition}* $
fn parse_program(p: &mut Parser) -> Result<Program, String> {
    let mut funcs = Vec::new();
    while *peek(p) != Tok::Eof {
        funcs.push(parse_fun_def(p)?);
    }
    Ok(Program { funcs })
}

pub fn parse(toks: Vec<Tok>) -> Result<Program, String> {
    let mut p = Parser { toks, pos: 0 };
    let prog = parse_program(&mut p)?;
    if *peek(&p) != Tok::Eof {
        return Err(format!(
            "parse error: trailing tokens, starting at {}",
            tok_to_string(peek(&p))
        ));
    }
    Ok(prog)
}

pub fn parse_string(s: &str) -> Result<Program, String> {
    let toks = tokenize(s)?;
    parse(toks)
}
