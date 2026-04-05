### begin my answer

### end my answer

function main()
    @assert abs(gaussian_integral(1, 1000) - 1.493648) < 1.0e-6
    @assert abs(gaussian_integral(2, 2000) - 1.764163) < 1.0e-6
    @assert abs(gaussian_integral(10, 10000) - sqrt(pi)) < 1.0e-6
    println("OK")
end

main()
