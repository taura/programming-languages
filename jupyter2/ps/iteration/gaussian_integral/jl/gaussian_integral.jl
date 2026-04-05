### begin my answer

### begin hidden
function gaussian_integral(a, n)
    dx = 2a / n
    s = 0.0
    for i in 0:n-1
        x = -a + i * dx
        s += exp(-(x * x)) * dx
    end
    s
end
### end hidden
### end my answer

function main()
    @assert abs(gaussian_integral(1, 1000) - 1.493648) < 1.0e-6
    @assert abs(gaussian_integral(2, 2000) - 1.764163) < 1.0e-6
    @assert abs(gaussian_integral(10, 10000) - sqrt(pi)) < 1.0e-6
    println("OK")
end

main()
