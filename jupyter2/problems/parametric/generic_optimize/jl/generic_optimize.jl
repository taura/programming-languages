### begin my answer

### end my answer

very_close(x, y) = abs(x - y) < 1e-6

function main()
    a0 = arange(0, 1, 10000)
    a1 = arange(0, 3, 10000)
    a2 = arange2d(-2, 2, 10000, -2, 2, 1000)
    f0(x) = x * (x - 1)
    f1(x) = x * (x - 1) * (x - 2)
    f2((x, y)) = x * x + 2 * y * y + 3 * x * y
    y0 = optimize(f0, a0)
    y1 = optimize(f1, a1)
    y2 = optimize(f2, a2)
    @assert(very_close(y0, -0.25))
    @assert(very_close(y1, -0.384900))
    @assert(very_close(y2, -0.5))
    println("OK")
end

main()
