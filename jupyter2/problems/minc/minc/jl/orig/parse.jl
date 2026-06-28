mutable struct Parser
    toks::Vector{Token}
    pos::Int
end

# report an error at the point it occurs and return nothing
function parsefail(msg::String)
    println(stderr, "parse error: " * msg)
    return nothing
end

peektok(p::Parser) = p.toks[p.pos]

function advance!(p::Parser)
    t = p.toks[p.pos]
    if p.pos < length(p.toks)
        p.pos += 1
    end
    return t
end

function expect!(p::Parser, k::TokKind)::Bool
    t = peektok(p)
    if t.kind != k
        parsefail("expected $(tokstr(Token(k))) but got $(tokstr(t))")
        return false
    end
    advance!(p)
    return true
end

# expr = equality_expr "=" expr | equality_expr
function parseExpr(p::Parser)::Union{Expr,Nothing}
    lhs = parseEquality(p)
    lhs === nothing && return nothing
    if peektok(p).kind == TAssign
        advance!(p)
        rhs = parseExpr(p)
        rhs === nothing && return nothing
        return Assign(lhs, rhs)
    end
    return lhs
end

# equality_expr = cmp_expr { ("=="|"!=") cmp_expr }*
function parseEquality(p::Parser)::Union{Expr,Nothing}
    lhs = parseCmp(p)
    lhs === nothing && return nothing
    while true
        k = peektok(p).kind
        if k == TEq || k == TNe
            advance!(p)
            rhs = parseCmp(p)
            rhs === nothing && return nothing
            lhs = Binary(k == TEq ? OpEq : OpNe, lhs, rhs)
        else
            return lhs
        end
    end
end

# cmp_expr = additive_expr { ("<="|">="|"<"|">") additive_expr }*
function parseCmp(p::Parser)::Union{Expr,Nothing}
    lhs = parseAdditive(p)
    lhs === nothing && return nothing
    while true
        k = peektok(p).kind
        op = if k == TLt
            OpLt
        elseif k == TGt
            OpGt
        elseif k == TLe
            OpLe
        elseif k == TGe
            OpGe
        else
            return lhs
        end
        advance!(p)
        rhs = parseAdditive(p)
        rhs === nothing && return nothing
        lhs = Binary(op, lhs, rhs)
    end
end

# additive_expr = multiplicative_expr { ("+"|"-") multiplicative_expr }*
function parseAdditive(p::Parser)::Union{Expr,Nothing}
    lhs = parseMul(p)
    lhs === nothing && return nothing
    while true
        k = peektok(p).kind
        op = if k == TPlus
            OpAdd
        elseif k == TMinus
            OpSub
        else
            return lhs
        end
        advance!(p)
        rhs = parseMul(p)
        rhs === nothing && return nothing
        lhs = Binary(op, lhs, rhs)
    end
end

# multiplicative_expr = unary_expr { ("*"|"/"|"%") unary_expr }*
function parseMul(p::Parser)::Union{Expr,Nothing}
    lhs = parseUnary(p)
    lhs === nothing && return nothing
    while true
        k = peektok(p).kind
        op = if k == TStar
            OpMul
        elseif k == TSlash
            OpDiv
        elseif k == TPercent
            OpMod
        else
            return lhs
        end
        advance!(p)
        rhs = parseUnary(p)
        rhs === nothing && return nothing
        lhs = Binary(op, lhs, rhs)
    end
end

# unary_expr = number | identifier "(" arg_list ")" | identifier | "(" expr ")" | ("+"|"-"|"!"|"~") unary_expr
function parseUnary(p::Parser)::Union{Expr,Nothing}
    t = peektok(p)
    k = t.kind
    if k == TNum
        advance!(p)
        return IntLit(t.num)
    elseif k == TPlus || k == TMinus || k == TNot || k == TTilde
        advance!(p)
        e = parseUnary(p)
        e === nothing && return nothing
        op = if k == TPlus
            OpPos
        elseif k == TMinus
            OpNeg
        elseif k == TNot
            OpLNot
        else
            OpBNot
        end
        return Unary(op, e)
    elseif k == TLParen
        advance!(p)
        e = parseExpr(p)
        e === nothing && return nothing
        expect!(p, TRParen) || return nothing
        return e
    elseif k == TId
        advance!(p)
        if peektok(p).kind == TLParen
            advance!(p)
            args = parseArgList(p)
            args === nothing && return nothing
            expect!(p, TRParen) || return nothing
            return Call(t.str, args)
        end
        return VarRef(t.str)
    else
        return parsefail("unexpected token $(tokstr(t)) in expression")
    end
end

# arg_list = [ expr { "," expr }* ]
function parseArgList(p::Parser)::Union{Vector{Expr},Nothing}
    args = Expr[]
    if peektok(p).kind == TRParen
        return args
    end
    e = parseExpr(p)
    e === nothing && return nothing
    push!(args, e)
    while peektok(p).kind == TComma
        advance!(p)
        e = parseExpr(p)
        e === nothing && return nothing
        push!(args, e)
    end
    return args
end

# type_expr = "long"
function parseType(p::Parser)::Union{TypeExpr,Nothing}
    expect!(p, TLong) || return nothing
    return TyLong
end

# identifier = /[A-Za-z_][A-Za-z_0-9]*/
function parseIdent(p::Parser)::Union{String,Nothing}
    t = advance!(p)
    if t.kind != TId
        return parsefail("expected identifier but got $(tokstr(t))")
    end
    return t.str
end

# stmt = ";" | "continue" ";" | "break" ";" | "return" expr ";" | compound_stmt | if_stmt | while_stmt | expr ";"
function parseStmt(p::Parser)::Union{Stmt,Nothing}
    k = peektok(p).kind
    if k == TSemi
        advance!(p)
        return EmptyStmt()
    elseif k == TContinue
        advance!(p)
        expect!(p, TSemi) || return nothing
        return ContinueStmt()
    elseif k == TBreak
        advance!(p)
        expect!(p, TSemi) || return nothing
        return BreakStmt()
    elseif k == TReturn
        advance!(p)
        e = parseExpr(p)
        e === nothing && return nothing
        expect!(p, TSemi) || return nothing
        return ReturnStmt(e)
    elseif k == TLBrace
        return parseCompound(p)
    elseif k == TIf
        return parseIf(p)
    else
        e = parseExpr(p)
        e === nothing && return nothing
        expect!(p, TSemi) || return nothing
        return ExprStmt(e)
    end
end

# compound_stmt = "{" {var_decl}* {stmt}* "}"
function parseCompound(p::Parser)::Union{Compound,Nothing}
    expect!(p, TLBrace) || return nothing
    decls = VarDecl[]
    while peektok(p).kind == TLong
        ty = parseType(p)
        ty === nothing && return nothing
        name = parseIdent(p)
        name === nothing && return nothing
        expect!(p, TSemi) || return nothing
        push!(decls, VarDecl(ty, name))
    end
    stmts = Stmt[]
    while peektok(p).kind != TRBrace
        s = parseStmt(p)
        s === nothing && return nothing
        push!(stmts, s)
    end
    expect!(p, TRBrace) || return nothing
    return Compound(decls, stmts)
end

# if_stmt = "if" "(" expr ")" stmt [ "else" stmt ]
function parseIf(p::Parser)::Union{Stmt,Nothing}
    expect!(p, TIf) || return nothing
    expect!(p, TLParen) || return nothing
    cond = parseExpr(p)
    cond === nothing && return nothing
    expect!(p, TRParen) || return nothing
    then = parseStmt(p)
    then === nothing && return nothing
    els = nothing
    if peektok(p).kind == TElse
        advance!(p)
        els = parseStmt(p)
        els === nothing && return nothing
    end
    return IfStmt(cond, then, els)
end


# parameter = type_expr identifier
function parseParam(p::Parser)::Union{Param,Nothing}
    ty = parseType(p)
    ty === nothing && return nothing
    name = parseIdent(p)
    name === nothing && return nothing
    return Param(ty, name)
end

# parameter_list = [ parameter { "," parameter }* ]
function parseParamList(p::Parser)::Union{Vector{Param},Nothing}
    params = Param[]
    if peektok(p).kind == TRParen
        return params
    end
    pm = parseParam(p)
    pm === nothing && return nothing
    push!(params, pm)
    while peektok(p).kind == TComma
        advance!(p)
        pm = parseParam(p)
        pm === nothing && return nothing
        push!(params, pm)
    end
    return params
end

# fun_definition = type_expr identifier "(" parameter_list ")" compound_stmt
function parseFunDef(p::Parser)::Union{FunDef,Nothing}
    ret = parseType(p)
    ret === nothing && return nothing
    name = parseIdent(p)
    name === nothing && return nothing
    expect!(p, TLParen) || return nothing
    params = parseParamList(p)
    params === nothing && return nothing
    expect!(p, TRParen) || return nothing
    body = parseCompound(p)
    body === nothing && return nothing
    return FunDef(ret, name, params, body)
end

# program = {definition}*
function parseProgram(p::Parser)::Union{Program,Nothing}
    funcs = FunDef[]
    while peektok(p).kind != TEOF
        f = parseFunDef(p)
        f === nothing && return nothing
        push!(funcs, f)
    end
    return Program(funcs)
end

function parse_tokens(toks::Vector{Token})::Union{Program,Nothing}
    p = Parser(toks, 1)
    prog = parseProgram(p)
    prog === nothing && return nothing
    if peektok(p).kind != TEOF
        return parsefail("trailing tokens, starting at $(tokstr(peektok(p)))")
    end
    return prog
end

function parse_string(s::String)::Union{Program,Nothing}
    toks = tokenize(s)
    toks === nothing && return nothing
    return parse_tokens(toks)
end
