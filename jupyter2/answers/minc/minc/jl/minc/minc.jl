#!/usr/bin/env julia

const SRCDIR = dirname(@__FILE__)
include(joinpath(SRCDIR, "ast.jl"))
include(joinpath(SRCDIR, "lex.jl"))
include(joinpath(SRCDIR, "parse.jl"))
include(joinpath(SRCDIR, "codegen.jl"))

read_input() = length(ARGS) >= 1 ? read(ARGS[1], String) : read(stdin, String)

function write_output(asm::String)
    if length(ARGS) >= 2
        open(ARGS[2], "w") do io
            write(io, asm)
        end
    else
        print(asm)
    end
end

function compile(src::String)::Union{String,Nothing}
    prog = parse_string(src)
    prog === nothing && return nothing
    return genProgram(prog)
end

function main()
    asm = compile(read_input())
    asm === nothing && exit(1)
    write_output(asm)
end

main()
