### begin my answer

### begin hidden
function triangle_area(x1, y1, x2, y2, x3, y3)
    dx21 = x2 - x1
    dy21 = y2 - y1
    dx31 = x3 - x1
    dy31 = y3 - y1
    0.5 * abs(dx21 * dy31 - dx31 * dy21)
end
### end hidden
### end my answer

function main()
    @assert abs(triangle_area(0,0,1,0,0,1) - 0.5) < 1.0e-5
    @assert abs(triangle_area(0,0,2,0,0,2) - 2.0) < 1.0e-5
    @assert abs(triangle_area(1,1,4,1,1,5) - 6.0) < 1.0e-5
    println("OK")
end

main()
