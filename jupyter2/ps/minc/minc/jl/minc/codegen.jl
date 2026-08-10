### begin hidden
mutable struct Codegen
    buf::IOBuffer
    offsets::Dict{String,Int}
    labelID::Int
    prefix::String
    retLabel::String
    loops::Vector{Tuple{String,String}}
end
Codegen() = Codegen(IOBuffer(), Dict{String,Int}(), 0, "", "", Tuple{String,String}[])

# report an error at the point it occurs and return nothing
function codegenfail(msg::String)
    println(stderr, "codegen error: " * msg)
    return nothing
end

emit(g::Codegen, s::String) = print(g.buf, s, "\n")

function freshLabel(g::Codegen)::String
    l = ".L$(g.prefix)_$(g.labelID)"
    g.labelID += 1
    return l
end

push_(g::Codegen) = emit(g, "\tstr\tx0, [sp, #-16]!")
pop_(g::Codegen, reg::String) = emit(g, "\tldr\t$(reg), [sp], #16")

align16(n::Int)::Int = div(n + 15, 16) * 16

function assignOffsets(g::Codegen, params::Vector{Param}, body::Stmt)::Int
    next = Ref(0)
    function alloc(name)
        next[] += 8
        g.offsets[name] = -next[]
    end
    for (i, p) in enumerate(params)
        if i <= 8
            alloc(p.name)
        else
            g.offsets[p.name] = 16 + 8 * (i - 1 - 8)
        end
    end
    function scan(s)
        if s isa Compound
            for d in s.decls
                alloc(d.name)
            end
            for x in s.stmts
                scan(x)
            end
        elseif s isa IfStmt
            scan(s.then)
            if s.els !== nothing
                scan(s.els)
            end
        elseif s isa WhileStmt
            scan(s.body)
        end
    end
    scan(body)
    return align16(next[])
end

# returns the frame offset, or nothing if the variable is undefined
function offsetOf(g::Codegen, name::String)::Union{Int,Nothing}
    if !haskey(g.offsets, name)
        return codegenfail("undefined variable " * name)
    end
    return g.offsets[name]
end

function cmpSet(g::Codegen, cond::String)
    emit(g, "\tcmp\tx1, x0")
    emit(g, "\tcset\tx0, $(cond)")
end

# generators below return true on success, false if an error was reported
function genExpr(g::Codegen, e::Expr)::Bool
    if e isa IntLit
        emit(g, "\tmov\tx0, #$(e.value)")
    elseif e isa VarRef
        off = offsetOf(g, e.name)
        off === nothing && return false
        emit(g, "\tldr\tx0, [x29, #$(off)]")
    elseif e isa Assign
        v = e.lhs
        if !(v isa VarRef)
            codegenfail("left-hand side of assignment must be a variable")
            return false
        end
        genExpr(g, e.rhs) || return false
        off = offsetOf(g, v.name)
        off === nothing && return false
        emit(g, "\tstr\tx0, [x29, #$(off)]")
    elseif e isa Unary
        genExpr(g, e.e) || return false
        if e.op == OpPos
        elseif e.op == OpNeg
            emit(g, "\tneg\tx0, x0")
        elseif e.op == OpBNot
            emit(g, "\tmvn\tx0, x0")
        elseif e.op == OpLNot
            emit(g, "\tcmp\tx0, #0")
            emit(g, "\tcset\tx0, eq")
        end
    elseif e isa Binary
        genExpr(g, e.l) || return false
        push_(g)
        genExpr(g, e.r) || return false
        pop_(g, "x1")
        op = e.op
        if op == OpAdd
            emit(g, "\tadd\tx0, x1, x0")
        elseif op == OpSub
            emit(g, "\tsub\tx0, x1, x0")
        elseif op == OpMul
            emit(g, "\tmul\tx0, x1, x0")
        elseif op == OpDiv
            emit(g, "\tsdiv\tx0, x1, x0")
        elseif op == OpMod
            emit(g, "\tsdiv\tx2, x1, x0")
            emit(g, "\tmsub\tx0, x2, x0, x1")
        elseif op == OpLt
            cmpSet(g, "lt")
        elseif op == OpGt
            cmpSet(g, "gt")
        elseif op == OpLe
            cmpSet(g, "le")
        elseif op == OpGe
            cmpSet(g, "ge")
        elseif op == OpEq
            cmpSet(g, "eq")
        elseif op == OpNe
            cmpSet(g, "ne")
        end
    elseif e isa Call
        return genCall(g, e)
    end
    return true
end

function genCall(g::Codegen, c::Call)::Bool
    n = length(c.args)
    k = n > 8 ? 8 : n
    nstack = n - k
    area = align16(8 * nstack)
    if area > 0
        emit(g, "\tsub\tsp, sp, #$(area)")
    end
    for i in 1:k
        genExpr(g, c.args[i]) || return false
        push_(g)
    end
    for i in 9:n
        genExpr(g, c.args[i]) || return false
        emit(g, "\tstr\tx0, [sp, #$(16*k + 8*(i-1-8))]")
    end
    for i in 0:k-1
        emit(g, "\tldr\tx$(i), [sp, #$(16*(k-1-i))]")
    end
    if k > 0
        emit(g, "\tadd\tsp, sp, #$(16*k)")
    end
    emit(g, "\tbl\t$(c.name)")
    if area > 0
        emit(g, "\tadd\tsp, sp, #$(area)")
    end
    return true
end

function genStmt(g::Codegen, s::Stmt)::Bool
    if s isa EmptyStmt
    elseif s isa ExprStmt
        return genExpr(g, s.e)
    elseif s isa ReturnStmt
        genExpr(g, s.e) || return false
        emit(g, "\tb\t$(g.retLabel)")
    elseif s isa Compound
        for x in s.stmts
            genStmt(g, x) || return false
        end
    elseif s isa IfStmt
        lElse = freshLabel(g)
        lEnd = freshLabel(g)
        genExpr(g, s.cond) || return false
        emit(g, "\tcmp\tx0, #0")
        emit(g, "\tbeq\t$(lElse)")
        genStmt(g, s.then) || return false
        emit(g, "\tb\t$(lEnd)")
        emit(g, "$(lElse):")
        if s.els !== nothing
            genStmt(g, s.els) || return false
        end
        emit(g, "$(lEnd):")
    elseif s isa WhileStmt
        lTop = freshLabel(g)
        lEnd = freshLabel(g)
        emit(g, "$(lTop):")
        genExpr(g, s.cond) || return false
        emit(g, "\tcmp\tx0, #0")
        emit(g, "\tbeq\t$(lEnd)")
        push!(g.loops, (lEnd, lTop))
        genStmt(g, s.body) || return false
        pop!(g.loops)
        emit(g, "\tb\t$(lTop)")
        emit(g, "$(lEnd):")
    elseif s isa BreakStmt
        if isempty(g.loops)
            codegenfail("break outside of loop")
            return false
        end
        emit(g, "\tb\t$(g.loops[end][1])")
    elseif s isa ContinueStmt
        if isempty(g.loops)
            codegenfail("continue outside of loop")
            return false
        end
        emit(g, "\tb\t$(g.loops[end][2])")
    end
    return true
end

function genFun(g::Codegen, f::FunDef)::Bool
    g.offsets = Dict{String,Int}()
    g.labelID = 0
    g.prefix = f.name
    g.retLabel = ".Lret_" * f.name
    empty!(g.loops)
    frame = assignOffsets(g, f.params, f.body)

    emit(g, "\t.text")
    emit(g, "\t.global\t$(f.name)")
    emit(g, "$(f.name):")
    emit(g, "\tstp\tx29, x30, [sp, #-16]!")
    emit(g, "\tmov\tx29, sp")
    if frame > 0
        emit(g, "\tsub\tsp, sp, #$(frame)")
    end
    for (i, p) in enumerate(f.params)
        if i <= 8
            off = offsetOf(g, p.name)
            off === nothing && return false
            emit(g, "\tstr\tx$(i-1), [x29, #$(off)]")
        end
    end
    genStmt(g, f.body) || return false
    emit(g, "\tmov\tx0, #0")
    emit(g, "$(g.retLabel):")
    emit(g, "\tmov\tsp, x29")
    emit(g, "\tldp\tx29, x30, [sp], #16")
    emit(g, "\tret")
    return true
end

function genProgram(prog::Program)::Union{String,Nothing}
    g = Codegen()
    for f in prog.funcs
        genFun(g, f) || return nothing
        print(g.buf, "\n")
    end
    return String(take!(g.buf))
end
### end hidden

### begin skeleton
function genProgram(prog::Program)::Union{String,Nothing}
    println(stderr, "codegen error: genProgram is not implemented yet")
    return nothing
end
### end skeleton
