### begin my answer

### end my answer

function main()
    @assert abs(triangle_area(0,0,1,0,0,1) - 0.5) < 1.0e-5
    @assert abs(triangle_area(0,0,2,0,0,2) - 2.0) < 1.0e-5
    @assert abs(triangle_area(1,1,4,1,1,5) - 6.0) < 1.0e-5
    println("OK")
end

main()
