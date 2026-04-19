### begin my answer

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
