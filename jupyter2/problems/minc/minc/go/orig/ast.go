package main

// type_expr = "long"
type TypeExpr int

const (
	TyLong TypeExpr = iota
)

// unary op: + - ! ~
type UnaryOp int

const (
	OpPos  UnaryOp = iota // +
	OpNeg                 // -
	OpLNot                // !
	OpBNot                // ~
)

// binary op: + - * / % < > <= >= == !=
type BinaryOp int

const (
	OpAdd BinaryOp = iota // +
	OpSub                 // -
	OpMul                 // *
	OpDiv                 // /
	OpMod                 // %
	OpLt                  // <
	OpGt                  // >
	OpLe                  // <=
	OpGe                  // >=
	OpEq                  // ==
	OpNe                  // !=
)

// expr
type Expr interface{ isExpr() }

type IntLit struct{ Value int64 } // number  123
type VarRef struct{ Name string } // identifier  x
type Call struct {                // call  f(x, y)
	Name string
	Args []Expr
}
type Unary struct { // unary  -x
	Op UnaryOp
	E  Expr
}
type Binary struct { // binary  x + y
	Op   BinaryOp
	L, R Expr
}
type Assign struct { // assignment  x = e
	LHS Expr
	RHS Expr
}

func (*IntLit) isExpr() {}
func (*VarRef) isExpr() {}
func (*Call) isExpr()   {}
func (*Unary) isExpr()  {}
func (*Binary) isExpr() {}
func (*Assign) isExpr() {}

// var_decl  "long x;"
type VarDecl struct {
	Type TypeExpr
	Name string
}

// stmt
type Stmt interface{ isStmt() }

type EmptyStmt struct{}          // ;
type ContinueStmt struct{}       // continue;
type BreakStmt struct{}          // break;
type ReturnStmt struct{ E Expr } // return e;
type Compound struct {           // { var_decl* stmt* }
	Decls []VarDecl
	Stmts []Stmt
}
type IfStmt struct { // if (e) s [else s]
	Cond Expr
	Then Stmt
	Else Stmt // nil if there is no else
}
type ExprStmt struct{ E Expr } // e;

func (*EmptyStmt) isStmt()    {}
func (*ContinueStmt) isStmt() {}
func (*BreakStmt) isStmt()    {}
func (*ReturnStmt) isStmt()   {}
func (*Compound) isStmt()     {}
func (*IfStmt) isStmt()       {}
func (*ExprStmt) isStmt()     {}

// parameter  "long x"
type Param struct {
	Type TypeExpr
	Name string
}

// fun_definition  "long f(long x, long y) { ... }"
type FunDef struct {
	RetType TypeExpr
	Name    string
	Params  []Param
	Body    *Compound
}

// program = {definition}*
type Program struct {
	Funcs []*FunDef
}
