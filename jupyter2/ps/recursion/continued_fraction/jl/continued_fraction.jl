### begin my answer

### begin hidden
function continued_fraction(a, n)
    if n == 0
        1.0
    else
        1.0 / (a + continued_fraction(a, n - 1))
    end
end
### end hidden
### end my answer

function main()
    @assert abs(continued_fraction(2.0, 100) - 0.4142136) < 1.0e-6
    @assert abs(continued_fraction(3.0, 100) - 0.3027756) < 1.0e-6
    @assert abs(continued_fraction(4.0, 100) - 0.2360680) < 1.0e-6
    println("OK")
end

main()
