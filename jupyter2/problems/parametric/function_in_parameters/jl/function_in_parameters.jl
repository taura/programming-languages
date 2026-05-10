### begin my answer

### end my answer

function main()
    @assert(app1(f) == 1.0)
    @assert(app1(g) == [1.0])
    @assert(app(f, 4) == 4)
    @assert(app(h, ["bye"]) == "bye")
    println("OK")
end

main()
