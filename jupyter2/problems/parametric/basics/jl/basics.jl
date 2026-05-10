### begin my answer

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
