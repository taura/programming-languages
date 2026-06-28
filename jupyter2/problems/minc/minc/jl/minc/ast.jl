# type_expr ("long")
@enum TypeExpr TyLong

# unary operators: +e, -e, !e, ~e
@enum UnaryOp OpPos OpNeg OpLNot OpBNot

# binary operators: + - * / % < > <= >= == !=
@enum BinaryOp OpAdd OpSub OpMul OpDiv OpMod OpLt OpGt OpLe OpGe OpEq OpNe

abstract type Expr end

# number (e.g. 123)
struct IntLit <: Expr
    value::Int64
end
# identifier (e.g. x)
struct VarRef <: Expr
    name::String
end
# call: f(x, y)
struct Call <: Expr
    name::String
    args::Vector{Expr}
end
# unary_expr: ("+"|"-"|"!"|"~") unary_expr
struct Unary <: Expr
    op::UnaryOp
    e::Expr
end
# binary expr: l op r (additive/multiplicative/cmp/equality)
struct Binary <: Expr
    op::BinaryOp
    l::Expr
    r::Expr
end
# expr: lhs "=" rhs
struct Assign <: Expr
    lhs::Expr
    rhs::Expr
end

# var_decl: type_expr identifier ";"
struct VarDecl
    type::TypeExpr
    name::String
end

abstract type Stmt end

# stmt: ";"
struct EmptyStmt <: Stmt end
# stmt: "continue" ";"
struct ContinueStmt <: Stmt end
# stmt: "break" ";"
struct BreakStmt <: Stmt end
# stmt: "return" expr ";"
struct ReturnStmt <: Stmt
    e::Expr
end
# if_stmt: "if" "(" expr ")" stmt [ "else" stmt ]
struct IfStmt <: Stmt
    cond::Expr
    then::Stmt
    els::Union{Stmt,Nothing}
end
# stmt: expr ";"
struct ExprStmt <: Stmt
    e::Expr
end
# compound_stmt: "{" {var_decl}* {stmt}* "}"
struct Compound <: Stmt
    decls::Vector{VarDecl}
    stmts::Vector{Stmt}
end

# parameter: type_expr identifier
struct Param
    type::TypeExpr
    name::String
end

# fun_definition: type_expr identifier "(" parameter_list ")" compound_stmt
struct FunDef
    rettype::TypeExpr
    name::String
    params::Vector{Param}
    body::Compound
end

# program: {definition}*
struct Program
    funcs::Vector{FunDef}
end
