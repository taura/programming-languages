### begin my answer

### begin hidden
function point_line_distance(x0, y0, x1, y1, p, q)
    dx, dy = x1 - x0, y1 - y0
    a, b = dy, -dx
    num = abs(a * (p - x0) + b * (q - y0))
    den = sqrt(a * a + b * b)
    num / den
end
### end hidden
### end my answer

function main()
    @assert abs(point_line_distance(-3.0, 1.0, 1.0, -2.0, 4.0, -3.0) - 1.0) < 1.0e-5
    @assert abs(point_line_distance( 2.0, 2.0, 4.0,  0.0, 1.0,  0.0) - 2.12132) < 1.0e-5
    @assert abs(point_line_distance( 1.0, 1.0, 4.0,  3.0, 3.0, -2.0) - 3.60555) < 1.0e-5
    println("OK")
end

main()
