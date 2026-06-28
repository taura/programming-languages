mutable struct TokenStream
    toks::Vector{Token}
    pos::Int
end

# report an error at the point it occurs and return nothing
function parsefail(msg::String)
    println(stderr, "parse error: " * msg)
    return nothing
end

peektok(t::TokenStream) = t.toks[t.pos]

function advance!(t::TokenStream)
    tok = t.toks[t.pos]
    if t.pos < length(t.toks)
        t.pos += 1
    end
    return tok
end

function expect!(t::TokenStream, k::TokKind)::Bool
    tok = peektok(t)
    if tok.kind != k
        parsefail("expected $(tokstr(Token(k))) but got $(tokstr(tok))")
        return false
    end
    advance!(t)
    return true
end

# expr = equality_expr "=" expr | equality_expr
function parseExpr(t::TokenStream)::Union{Expr,Nothing}
    lhs = parseEquality(t)
    lhs === nothing && return nothing
    if peektok(t).kind == TAssign
        advance!(t)
        rhs = parseExpr(t)
        rhs === nothing && return nothing
        return Assign(lhs, rhs)
    end
    return lhs
end

# equality_expr = cmp_expr { ("=="|"!=") cmp_expr }*
function parseEquality(t::TokenStream)::Union{Expr,Nothing}
    lhs = parseCmp(t)
    lhs === nothing && return nothing
    while true
        k = peektok(t).kind
        if k == TEq || k == TNe
            advance!(t)
            rhs = parseCmp(t)
            rhs === nothing && return nothing
            lhs = Binary(k == TEq ? OpEq : OpNe, lhs, rhs)
        else
            return lhs
        end
    end
end

# cmp_expr = additive_expr { ("<="|">="|"<"|">") additive_expr }*
function parseCmp(t::TokenStream)::Union{Expr,Nothing}
    lhs = parseAdditive(t)
    lhs === nothing && return nothing
    while true
        k = peektok(t).kind
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
        advance!(t)
        rhs = parseAdditive(t)
        rhs === nothing && return nothing
        lhs = Binary(op, lhs, rhs)
    end
end

# additive_expr = multiplicative_expr { ("+"|"-") multiplicative_expr }*
function parseAdditive(t::TokenStream)::Union{Expr,Nothing}
    lhs = parseMul(t)
    lhs === nothing && return nothing
    while true
        k = peektok(t).kind
        op = if k == TPlus
            OpAdd
        elseif k == TMinus
            OpSub
        else
            return lhs
        end
        advance!(t)
        rhs = parseMul(t)
        rhs === nothing && return nothing
        lhs = Binary(op, lhs, rhs)
    end
end

# multiplicative_expr = unary_expr { ("*"|"/"|"%") unary_expr }*
function parseMul(t::TokenStream)::Union{Expr,Nothing}
    lhs = parseUnary(t)
    lhs === nothing && return nothing
    while true
        k = peektok(t).kind
        op = if k == TStar
            OpMul
        elseif k == TSlash
            OpDiv
        elseif k == TPercent
            OpMod
        else
            return lhs
        end
        advance!(t)
        rhs = parseUnary(t)
        rhs === nothing && return nothing
        lhs = Binary(op, lhs, rhs)
    end
end

# unary_expr = number | identifier "(" arg_list ")" | identifier | "(" expr ")" | ("+"|"-"|"!"|"~") unary_expr
function parseUnary(t::TokenStream)::Union{Expr,Nothing}
    tok = peektok(t)
    k = tok.kind
    if k == TNum
        advance!(t)
        return IntLit(tok.num)
    elseif k == TPlus || k == TMinus || k == TNot || k == TTilde
        advance!(t)
        e = parseUnary(t)
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
        advance!(t)
        e = parseExpr(t)
        e === nothing && return nothing
        expect!(t, TRParen) || return nothing
        return e
    elseif k == TId
        advance!(t)
        if peektok(t).kind == TLParen
            advance!(t)
            args = parseArgList(t)
            args === nothing && return nothing
            expect!(t, TRParen) || return nothing
            return Call(tok.str, args)
        end
        return VarRef(tok.str)
    else
        return parsefail("unexpected token $(tokstr(tok)) in expression")
    end
end

# arg_list = [ expr { "," expr }* ]
function parseArgList(t::TokenStream)::Union{Vector{Expr},Nothing}
    args = Expr[]
    if peektok(t).kind == TRParen
        return args
    end
    e = parseExpr(t)
    e === nothing && return nothing
    push!(args, e)
    while peektok(t).kind == TComma
        advance!(t)
        e = parseExpr(t)
        e === nothing && return nothing
        push!(args, e)
    end
    return args
end

# type_expr = "long"
function parseType(t::TokenStream)::Union{TypeExpr,Nothing}
    expect!(t, TLong) || return nothing
    return TyLong
end

# identifier = /[A-Za-z_][A-Za-z_0-9]*/
function parseIdent(t::TokenStream)::Union{String,Nothing}
    tok = advance!(t)
    if tok.kind != TId
        return parsefail("expected identifier but got $(tokstr(tok))")
    end
    return tok.str
end

# stmt = ";" | "continue" ";" | "break" ";" | "return" expr ";" | compound_stmt | if_stmt | while_stmt | expr ";"
function parseStmt(t::TokenStream)::Union{Stmt,Nothing}
    k = peektok(t).kind
    if k == TSemi
        advance!(t)
        return EmptyStmt()
    elseif k == TContinue
        advance!(t)
        expect!(t, TSemi) || return nothing
        return ContinueStmt()
    elseif k == TBreak
        advance!(t)
        expect!(t, TSemi) || return nothing
        return BreakStmt()
    elseif k == TReturn
        advance!(t)
        e = parseExpr(t)
        e === nothing && return nothing
        expect!(t, TSemi) || return nothing
        return ReturnStmt(e)
    elseif k == TLBrace
        return parseCompound(t)
    elseif k == TIf
        return parseIf(t)
    else
        e = parseExpr(t)
        e === nothing && return nothing
        expect!(t, TSemi) || return nothing
        return ExprStmt(e)
    end
end

# compound_stmt = "{" {var_decl}* {stmt}* "}"
function parseCompound(t::TokenStream)::Union{Compound,Nothing}
    expect!(t, TLBrace) || return nothing
    decls = VarDecl[]
    while peektok(t).kind == TLong
        ty = parseType(t)
        ty === nothing && return nothing
        name = parseIdent(t)
        name === nothing && return nothing
        expect!(t, TSemi) || return nothing
        push!(decls, VarDecl(ty, name))
    end
    stmts = Stmt[]
    while peektok(t).kind != TRBrace
        s = parseStmt(t)
        s === nothing && return nothing
        push!(stmts, s)
    end
    expect!(t, TRBrace) || return nothing
    return Compound(decls, stmts)
end

# if_stmt = "if" "(" expr ")" stmt [ "else" stmt ]
function parseIf(t::TokenStream)::Union{Stmt,Nothing}
    expect!(t, TIf) || return nothing
    expect!(t, TLParen) || return nothing
    cond = parseExpr(t)
    cond === nothing && return nothing
    expect!(t, TRParen) || return nothing
    then = parseStmt(t)
    then === nothing && return nothing
    els = nothing
    if peektok(t).kind == TElse
        advance!(t)
        els = parseStmt(t)
        els === nothing && return nothing
    end
    return IfStmt(cond, then, els)
end


# parameter = type_expr identifier
function parseParam(t::TokenStream)::Union{Param,Nothing}
    ty = parseType(t)
    ty === nothing && return nothing
    name = parseIdent(t)
    name === nothing && return nothing
    return Param(ty, name)
end

# parameter_list = [ parameter { "," parameter }* ]
function parseParamList(t::TokenStream)::Union{Vector{Param},Nothing}
    params = Param[]
    if peektok(t).kind == TRParen
        return params
    end
    pm = parseParam(t)
    pm === nothing && return nothing
    push!(params, pm)
    while peektok(t).kind == TComma
        advance!(t)
        pm = parseParam(t)
        pm === nothing && return nothing
        push!(params, pm)
    end
    return params
end

# fun_definition = type_expr identifier "(" parameter_list ")" compound_stmt
function parseFunDef(t::TokenStream)::Union{FunDef,Nothing}
    ret = parseType(t)
    ret === nothing && return nothing
    name = parseIdent(t)
    name === nothing && return nothing
    expect!(t, TLParen) || return nothing
    params = parseParamList(t)
    params === nothing && return nothing
    expect!(t, TRParen) || return nothing
    body = parseCompound(t)
    body === nothing && return nothing
    return FunDef(ret, name, params, body)
end

# program = {definition}*
function parseProgram(t::TokenStream)::Union{Program,Nothing}
    funcs = FunDef[]
    while peektok(t).kind != TEOF
        f = parseFunDef(t)
        f === nothing && return nothing
        push!(funcs, f)
    end
    return Program(funcs)
end

function parse_tokens(toks::Vector{Token})::Union{Program,Nothing}
    t = TokenStream(toks, 1)
    prog = parseProgram(t)
    prog === nothing && return nothing
    if peektok(t).kind != TEOF
        return parsefail("trailing tokens, starting at $(tokstr(peektok(t)))")
    end
    return prog
end

function parse_string(s::String)::Union{Program,Nothing}
    toks = tokenize(s)
    toks === nothing && return nothing
    return parse_tokens(toks)
end
