/** begin hidden */
use crate::ast::*;
use std::collections::HashMap;
use std::fmt::Write;

pub struct Codegen {
    buf: String,
    offsets: HashMap<String, i64>,
    label_id: i64,
    prefix: String,
    ret_label: String,
    loops: Vec<(String, String)>,
}

fn align16(n: i64) -> i64 {
    (n + 15) / 16 * 16
}

fn new_codegen() -> Codegen {
    Codegen {
        buf: String::new(),
        offsets: HashMap::new(),
        label_id: 0,
        prefix: String::new(),
        ret_label: String::new(),
        loops: Vec::new(),
    }
}

fn emit(g: &mut Codegen, s: &str) {
    g.buf.push_str(s);
    g.buf.push('\n');
}

fn fresh_label(g: &mut Codegen) -> String {
    let l = format!(".L{}_{}", g.prefix, g.label_id);
    g.label_id += 1;
    l
}

fn push(g: &mut Codegen) {
    emit(g, "\tstr\tx0, [sp, #-16]!");
}
fn pop(g: &mut Codegen, reg: &str) {
    emit(g, &format!("\tldr\t{}, [sp], #16", reg));
}

fn assign_offsets(g: &mut Codegen, params: &[Param], body: &Compound) -> i64 {
    let mut next: i64 = 0;
    for (i, p) in params.iter().enumerate() {
        if i < 8 {
            next += 8;
            g.offsets.insert(p.name.clone(), -next);
        } else {
            g.offsets
                .insert(p.name.clone(), 16 + 8 * (i as i64 - 8));
        }
    }
    scan_stmt_compound(g, body, &mut next);
    align16(next)
}

fn scan_stmt_compound(g: &mut Codegen, c: &Compound, next: &mut i64) {
    for d in &c.decls {
        *next += 8;
        g.offsets.insert(d.name.clone(), -*next);
    }
    for s in &c.stmts {
        scan_stmt(g, s, next);
    }
}

fn scan_stmt(g: &mut Codegen, s: &Stmt, next: &mut i64) {
    match s {
        Stmt::Compound(c) => scan_stmt_compound(g, c, next),
        Stmt::If(_, then, els) => {
            scan_stmt(g, then, next);
            if let Some(e) = els {
                scan_stmt(g, e, next);
            }
        }
        Stmt::While(_, body) => scan_stmt(g, body, next),
        _ => {}
    }
}

fn offset_of(g: &Codegen, name: &str) -> Result<i64, String> {
    g.offsets
        .get(name)
        .copied()
        .ok_or_else(|| format!("codegen error: undefined variable {}", name))
}

fn gen_expr(g: &mut Codegen, e: &Expr) -> Result<(), String> {
    match e {
        Expr::IntLit(v) => emit(g, &format!("\tmov\tx0, #{}", v)),
        Expr::VarRef(name) => {
            let off = offset_of(g, name)?;
            emit(g, &format!("\tldr\tx0, [x29, #{}]", off));
        }
        Expr::Assign(lhs, rhs) => {
            let name = match lhs.as_ref() {
                Expr::VarRef(n) => n.clone(),
                _ => {
                    return Err(
                        "codegen error: left-hand side of assignment must be a variable"
                            .to_string(),
                    );
                }
            };
            gen_expr(g, rhs)?;
            let off = offset_of(g, &name)?;
            emit(g, &format!("\tstr\tx0, [x29, #{}]", off));
        }
        Expr::Unary(op, sub) => {
            gen_expr(g, sub)?;
            match op {
                UnaryOp::Pos => {}
                UnaryOp::Neg => emit(g, "\tneg\tx0, x0"),
                UnaryOp::BNot => emit(g, "\tmvn\tx0, x0"),
                UnaryOp::LNot => {
                    emit(g, "\tcmp\tx0, #0");
                    emit(g, "\tcset\tx0, eq");
                }
            }
        }
        Expr::Binary(op, l, r) => {
            gen_expr(g, l)?;
            push(g);
            gen_expr(g, r)?;
            pop(g, "x1");
            match op {
                BinaryOp::Add => emit(g, "\tadd\tx0, x1, x0"),
                BinaryOp::Sub => emit(g, "\tsub\tx0, x1, x0"),
                BinaryOp::Mul => emit(g, "\tmul\tx0, x1, x0"),
                BinaryOp::Div => emit(g, "\tsdiv\tx0, x1, x0"),
                BinaryOp::Mod => {
                    emit(g, "\tsdiv\tx2, x1, x0");
                    emit(g, "\tmsub\tx0, x2, x0, x1");
                }
                BinaryOp::Lt => cmp_set(g, "lt"),
                BinaryOp::Gt => cmp_set(g, "gt"),
                BinaryOp::Le => cmp_set(g, "le"),
                BinaryOp::Ge => cmp_set(g, "ge"),
                BinaryOp::Eq => cmp_set(g, "eq"),
                BinaryOp::Ne => cmp_set(g, "ne"),
            }
        }
        Expr::Call(name, args) => gen_call(g, name, args)?,
    }
    Ok(())
}

fn cmp_set(g: &mut Codegen, cond: &str) {
    emit(g, "\tcmp\tx1, x0");
    emit(g, &format!("\tcset\tx0, {}", cond));
}

fn gen_call(g: &mut Codegen, name: &str, args: &[Expr]) -> Result<(), String> {
    let n = args.len();
    let k = if n > 8 { 8 } else { n };
    let nstack = n - k;
    let area = align16(8 * nstack as i64);
    if area > 0 {
        emit(g, &format!("\tsub\tsp, sp, #{}", area));
    }
    for i in 0..k {
        gen_expr(g, &args[i])?;
        push(g);
    }
    for i in 8..n {
        gen_expr(g, &args[i])?;
        emit(g, &format!("\tstr\tx0, [sp, #{}]", 16 * k + 8 * (i - 8)));
    }
    for i in 0..k {
        emit(g, &format!("\tldr\tx{}, [sp, #{}]", i, 16 * (k - 1 - i)));
    }
    if k > 0 {
        emit(g, &format!("\tadd\tsp, sp, #{}", 16 * k));
    }
    emit(g, &format!("\tbl\t{}", name));
    if area > 0 {
        emit(g, &format!("\tadd\tsp, sp, #{}", area));
    }
    Ok(())
}

fn gen_stmt(g: &mut Codegen, s: &Stmt) -> Result<(), String> {
    match s {
        Stmt::Empty => {}
        Stmt::ExprStmt(e) => gen_expr(g, e)?,
        Stmt::Return(e) => {
            gen_expr(g, e)?;
            let rl = g.ret_label.clone();
            emit(g, &format!("\tb\t{}", rl));
        }
        Stmt::Compound(c) => {
            for x in &c.stmts {
                gen_stmt(g, x)?;
            }
        }
        Stmt::If(cond, then, els) => {
            let l_else = fresh_label(g);
            let l_end = fresh_label(g);
            gen_expr(g, cond)?;
            emit(g, "\tcmp\tx0, #0");
            emit(g, &format!("\tbeq\t{}", l_else));
            gen_stmt(g, then)?;
            emit(g, &format!("\tb\t{}", l_end));
            emit(g, &format!("{}:", l_else));
            if let Some(e) = els {
                gen_stmt(g, e)?;
            }
            emit(g, &format!("{}:", l_end));
        }
        Stmt::While(cond, body) => {
            let l_top = fresh_label(g);
            let l_end = fresh_label(g);
            emit(g, &format!("{}:", l_top));
            gen_expr(g, cond)?;
            emit(g, "\tcmp\tx0, #0");
            emit(g, &format!("\tbeq\t{}", l_end));
            g.loops.push((l_end.clone(), l_top.clone()));
            gen_stmt(g, body)?;
            g.loops.pop();
            emit(g, &format!("\tb\t{}", l_top));
            emit(g, &format!("{}:", l_end));
        }
        Stmt::Break => match g.loops.last() {
            Some((b, _)) => {
                let b = b.clone();
                emit(g, &format!("\tb\t{}", b));
            }
            None => return Err("codegen error: break outside of loop".to_string()),
        },
        Stmt::Continue => match g.loops.last() {
            Some((_, c)) => {
                let c = c.clone();
                emit(g, &format!("\tb\t{}", c));
            }
            None => return Err("codegen error: continue outside of loop".to_string()),
        },
    }
    Ok(())
}

fn gen_fun(g: &mut Codegen, f: &FunDef) -> Result<(), String> {
    g.offsets = HashMap::new();
    g.label_id = 0;
    g.prefix = f.name.clone();
    g.ret_label = format!(".Lret_{}", f.name);
    g.loops = Vec::new();
    let frame = assign_offsets(g, &f.params, &f.body);

    emit(g, "\t.text");
    emit(g, &format!("\t.global\t{}", f.name));
    emit(g, &format!("{}:", f.name));
    emit(g, "\tstp\tx29, x30, [sp, #-16]!");
    emit(g, "\tmov\tx29, sp");
    if frame > 0 {
        emit(g, &format!("\tsub\tsp, sp, #{}", frame));
    }
    for (i, p) in f.params.iter().enumerate() {
        if i < 8 {
            let off = offset_of(g, &p.name)?;
            emit(g, &format!("\tstr\tx{}, [x29, #{}]", i, off));
        }
    }
    let body = Stmt::Compound(f.body.clone());
    gen_stmt(g, &body)?;
    emit(g, "\tmov\tx0, #0");
    let rl = g.ret_label.clone();
    emit(g, &format!("{}:", rl));
    emit(g, "\tmov\tsp, x29");
    emit(g, "\tldp\tx29, x30, [sp], #16");
    emit(g, "\tret");
    Ok(())
}

pub fn gen_program(prog: &Program) -> Result<String, String> {
    let mut g = new_codegen();
    for f in &prog.funcs {
        gen_fun(&mut g, f)?;
        let _ = write!(g.buf, "\n");
    }
    Ok(g.buf)
}
/** end hidden */

/** begin skeleton */
use crate::ast::Program;
pub fn gen_program(prog: &Program) -> Result<String, String> {
    let _ = prog;
    Err("gen_program is not implemented yet".to_string())
}
/** end skeleton */
