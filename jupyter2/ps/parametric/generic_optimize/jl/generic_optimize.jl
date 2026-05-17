### begin my answer

### begin hidden
mutable struct Arange
    a::Float64
    b::Float64
    i::Int
    n::Int
    dx::Float64
end

function arange(a, b, n)
    Arange(a, b, 0, n, (b - a) / (n - 1))
end

function next(a::Arange)
    if a.i == a.n
        nothing
    else
        x = a.a + a.dx * a.i
        a.i += 1
        x
    end
end

mutable struct Arange2d
    x0::Float64
    x1::Float64
    m::Int
    y0::Float64
    y1::Float64
    n::Int
    i::Int
    j::Int
    dx::Float64
    dy::Float64
end

function arange2d(x0, x1, m, y0, y1, n)
    dx = (x1 - x0) / (m - 1)
    dy = (y1 - y0) / (n - 1)
    Arange2d(x0, x1, m, y0, y1, n, 0, 0, dx, dy)
end

function next(a::Arange2d)
    if a.i == a.m
        nothing
    else
        x = a.x0 + a.dx * a.i
        y = a.y0 + a.dy * a.j
        if a.j + 1 == a.n
            a.i += 1
            a.j = 0
        else
            a.j += 1
        end
        (x, y)
    end
end

function optimize(f, rng)
    minx, miny = nothing, nothing
    x = next(rng)
    while x != nothing
        y = f(x)
        if miny == nothing || y < miny
            minx, miny = x, y
        end
        x = next(rng)
    end
    miny
end

### end hidden
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
