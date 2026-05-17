### begin my answer

### begin hidden
f(x) = x

g(x) = [x]

mutable struct cell
    x
end

function get(c::cell)
    c.x
end

function put!(c::cell, y)
    c.x = y
end

function h(a)
    if length(a) == 0
        nothing
    else
        a[1]
    end
end
### end hidden
### end my answer

function main()
    @assert(f(1) == 1)
    @assert(f("hello") == "hello")
    @assert(g(2) == [2])
    @assert(g("world") == ["world"])
    c0 = cell(0)
    @assert(get(c0) == 0)
    put!(c0, 42)
    c1 = cell("mimura")
    @assert(get(c1) == "mimura");
    put!(c1, "ohtake");
    @assert(get(c1) == "ohtake");
    @assert(h([]) == nothing)
    @assert(h([3]) == 3)
    @assert(h(["bye"]) == "bye")
    println("OK")
end

main()
