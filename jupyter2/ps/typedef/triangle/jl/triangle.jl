### begin my answer

### begin hidden
struct Vec2
    x::Float64
    y::Float64
end

# a function that takes two Vec2's and returns a - b
import Base: -
function -(a::Vec2, b::Vec2)
    Vec2(a.x - b.x, a.y - b.y)
end

# a function that takes two Vec2's and returns the cross product of them
function cross(a::Vec2, b::Vec2)
    a.x * b.y - a.y * b.x
end

struct Triangle
    a::Vec2
    b::Vec2
    c::Vec2
end

function area_of_triangle(t::Triangle)
    0.5 * abs(cross(t.b - t.a, t.c - t.a))
end

### end hidden
### end my answer
function check(x0, y0, x1, y1, x2, y2, a)
    t = Triangle(Vec2(x0, y0), Vec2(x1, y1), Vec2(x2, y2))
    abs(area_of_triangle(t) - a) < 1e-6
end

function main()
    @assert check(0.,  0.,  1.,  0.,  0.,  1.,  0.500)
    @assert check(9.9, 0.3, 3.2, 5.1, 6.1, 0.2,  9.455)
    @assert check(4.6, 6.4, 0.4, 0.3, 5.5, 9.1,  2.925)
    @assert check(5.2, 5.5, 9.9, 0.0, 3.1, 4.0,  9.300)
    @assert check(6.0, 1.2, 0.6, 5.5, 9.9, 3.2, 13.785)
    println("OK")
end

main()
