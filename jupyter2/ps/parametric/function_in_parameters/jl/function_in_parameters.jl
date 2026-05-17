### begin my answer

### begin hidden
f(x) = x

g(x) = [x]

function h(a)
    if length(a) == 0
        nothing
    else
        a[1]
    end
end

app1(g) = g(1.0)

app(f, x) = f(x)

### end hidden
### end my answer

function main()
    @assert(app1(f) == 1.0)
    @assert(app1(g) == [1.0])
    @assert(app(f, 4) == 4)
    @assert(app(h, ["bye"]) == "bye")
    println("OK")
end

main()
