// type_expr ("long")
#[derive(Clone, Copy, Debug)]
pub enum TypeExpr {
    Long,
}

// unary operator: + - ! ~
#[derive(Clone, Copy, Debug)]
pub enum UnaryOp {
    Pos,  // +
    Neg,  // -
    LNot, // ! logical not
    BNot, // ~ bitwise not
}

// binary operator
#[derive(Clone, Copy, Debug)]
pub enum BinaryOp {
    Add, // +
    Sub, // -
    Mul, // *
    Div, // /
    Mod, // %
    Lt,  // <
    Gt,  // >
    Le,  // <=
    Ge,  // >=
    Eq,  // ==
    Ne,  // !=
}

// expression
#[derive(Clone, Debug)]
pub enum Expr {
    IntLit(i64),                       // integer literal 123
    VarRef(String),                    // variable reference x
    Call(String, Vec<Expr>),           // function call f(x, y)
    Unary(UnaryOp, Box<Expr>),         // unary operation -x
    Binary(BinaryOp, Box<Expr>, Box<Expr>), // binary operation x + y
    Assign(Box<Expr>, Box<Expr>),      // assignment x = e
}

// variable declaration "long x;"
#[derive(Clone, Debug)]
pub struct VarDecl {
    pub ty: TypeExpr,
    pub name: String,
}

// statement
#[derive(Clone, Debug)]
pub enum Stmt {
    Empty,                                 // ;
    Continue,                              // continue;
    Break,                                 // break;
    Return(Expr),                          // return e;
    Compound(Compound),                    // { decl* stmt* }
    If(Expr, Box<Stmt>, Option<Box<Stmt>>), // if (e) s [else s]
    ExprStmt(Expr),                        // e;
}

#[derive(Clone, Debug)]
pub struct Compound {
    pub decls: Vec<VarDecl>,
    pub stmts: Vec<Stmt>,
}

// parameter "long x"
#[derive(Clone, Debug)]
pub struct Param {
    pub ty: TypeExpr,
    pub name: String,
}

// function definition "long f(long x, long y) { ... }"
#[derive(Clone, Debug)]
pub struct FunDef {
    pub ret_type: TypeExpr,
    pub name: String,
    pub params: Vec<Param>,
    pub body: Compound,
}

// whole program = sequence of function definitions
#[derive(Clone, Debug)]
pub struct Program {
    pub funcs: Vec<FunDef>,
}
