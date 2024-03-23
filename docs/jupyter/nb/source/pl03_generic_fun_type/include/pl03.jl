### if label == "A function that takes a function"
f(g) = g(1.0)
### endif
### if label == "A domain class for a floating point number"
mutable struct random_float_generator
    a :: Float64
    b :: Float64
    n :: Int64
    i :: Int64
end

function random_float_generator(a, b, n)
    random_float_generator(a, b, n, 0)
end

function next(rfg :: random_float_generator)
    if rfg.i < rfg.n 
        x = rfg.a + (rfg.b - rfg.a) * rand(Float64)
        rfg.i += 1
        x
    else
        nothing
    end
end
### endif
### if 0
function print_random() 
    rfg = random_float_generator(2.0, 3.0, 10)
    while true
        f = next(rfg)
        if f == nothing
            break
        end
        println(f)
    end
end
### endif
### if label == "A minimizer for float -> float functions"
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
### endif
### if label == "Apply float -> float minimizer"
minimize(x -> x*(x-1)*(x-2), random_float_generator(0.0, 2.0, 10000))
### endif
### if label == "A somewhat generic float -> float minimizer"
# same as above (Problem 3)
### endif
### if label == "Apply a somewhat generic float -> float minimizer"
# same as above (Problem 4)
### endif
### if label == "Define a trivial generic type and a function"
struct Triv
    x
end
triv_val(t) = t.x
### endif
### if label == "A generic T -> float minimizer"
# same as above (Problem 3)
### endif
### if label == "Apply a generic T -> float minimizer"
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

minimize(((x, y),) -> x * x + y * y,
         ellipse_generator(3.0, 3.0, 2.0, 1.0, 10000))
### endif
