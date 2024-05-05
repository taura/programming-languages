import Printf

function minimize(f, rfg)
    min_x = nothing
    min_y = nothing
    while true
        x = next(rfg)
        if x == nothing
            return (min_x, min_y)
        end
        y = f(x)
        if min_x == nothing || y < min_y
            min_x, min_y = x, y
        end
    end
end

mutable struct ellipse_generator
    x0 :: Float64
    y0 :: Float64
    a :: Float64
    b :: Float64
    n :: Int64
    i :: Int64
end

function ellipse_generator(x0, y0, a, b, n)
    ellipse_generator(x0, y0, a, b, n, 0)
end

function next(eg :: ellipse_generator)
    if eg.i < eg.n
        while true 
            rx = -1.0 + 2.0 * rand(Float64)
            ry = -1.0 + 2.0 * rand(Float64)
            if rx * rx + ry * ry < 1.0
                x = eg.x0 + eg.a * rx
                y = eg.y0 + eg.b * ry
                eg.i += 1
                return (x, y)
            end
        end
    else
        nothing
    end
end

function main()
    (x, y), z = minimize(((x, y),) -> x * x + y * y,
                         ellipse_generator(3.0, 3.0, 2.0, 1.0, 10000))
    Printf.@printf "(x, y) = (%f, %f), f(x, y) = %f\n" x y z
end

main()
