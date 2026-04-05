### begin my answer

### begin hidden
function f(a, b, c)
    a * a + b * b - c * c
end
### end hidden
### end my answer

function main()
    @assert abs(f(1.0, 2.0, 3.0) - -4.0) <= 1.0e-5
    @assert abs(f(3.0, 4.0, 5.0) -  0.0) <= 1.0e-5
    @assert abs(f(5.0, 6.0, 7.0) - 12.0) <= 1.0e-5
    println("OK")
end

main()
