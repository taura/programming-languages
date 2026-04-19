### begin my answer

### end my answer

function main()
    @assert abs(continued_fraction(2.0, 100) - 0.4142136) < 1.0e-6
    @assert abs(continued_fraction(3.0, 100) - 0.3027756) < 1.0e-6
    @assert abs(continued_fraction(4.0, 100) - 0.2360680) < 1.0e-6
    println("OK")
end

main()
