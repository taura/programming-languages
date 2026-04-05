### begin my answer

### begin hidden
function min_value(a, b, n)
    f(x) = x^4 - 3x^3 + 2x^2 + x + 1
    best = f(a)
    for i in 1:n
        x = a + (b - a) * i / n
        v = f(x)
        if v < best
            best = v
        end
    end
    best
end
### end hidden
### end my answer

function main()
    @assert abs(min_value(-1, 1, 1000) - 0.903266) < 1.0e-6
    @assert abs(min_value( 1, 2, 1000) - 1.928766) < 1.0e-6
    println("OK")
end

main()
