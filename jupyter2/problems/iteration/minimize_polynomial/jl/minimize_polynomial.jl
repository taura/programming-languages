### begin my answer

### end my answer

function main()
    @assert abs(min_value(-1, 1, 1000) - 0.903266) < 1.0e-6
    @assert abs(min_value( 1, 2, 1000) - 1.928766) < 1.0e-6
    println("OK")
end

main()
