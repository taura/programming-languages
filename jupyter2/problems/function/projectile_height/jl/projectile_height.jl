### begin my answer

### end my answer

function main()
    @assert abs(height(10,  1, 1) - 6.1) < 1e-5
    @assert abs(height(20,  0, 2) - 0.4) < 1e-5
    @assert abs(height(30, -1, 3) - -17.1) < 1e-5
    println("OK")
end

main()
