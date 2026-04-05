### begin my answer

### begin hidden
height(h0, v0, t) = h0 + v0 * t - 0.5 * 9.8 * t * t
### end hidden
### end my answer

function main()
    @assert abs(height(10,  1, 1) - 6.1) < 1e-5
    @assert abs(height(20,  0, 2) - 0.4) < 1e-5
    @assert abs(height(30, -1, 3) - -17.1) < 1e-5
    println("OK")
end

main()
