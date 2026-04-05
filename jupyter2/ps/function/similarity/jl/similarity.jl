### begin my answer

### begin hidden
similarity(a,b,c,d) = (a*c + b*d) / (sqrt(a^2+b^2)*sqrt(c^2+d^2))
### end hidden
### end my answer

function main()
    @assert abs(similarity(1.0, 2.0,  2.0,  4.0) - 1.0) < 1e-5
    @assert abs(similarity(1.0, 2.0,  3.0,  5.0) - 0.997054) < 1e-5
    @assert abs(similarity(2.0, 3.0,  3.0, -2.0) - 0.0) < 1e-5
    @assert abs(similarity(3.0, 4.0, -3.0, -1.0) - -0.82219) < 1e-5
    println("OK")
end

main()
