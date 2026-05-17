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

function optimize(f, rng)
    miny = nothing
    x = next(rng)
    while x != nothing
        y = f(x)
        if miny == nothing || y < miny
            miny = y
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
    f0(x) = x * (x - 1)
    f1(x) = x * (x - 1) * (x - 2)
    y0 = optimize(f0, a0)
    y1 = optimize(f1, a1)
    @assert(very_close(y0, -0.25))
    @assert(very_close(y1, -0.384900))
    println("OK")
end

main()
