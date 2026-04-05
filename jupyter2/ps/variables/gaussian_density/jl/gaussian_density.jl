### begin my answer

### begin hidden
function gaussian_density(mu, sigma, x)
    z = (x - mu) / sigma
    z2 = z * z
    norm = 1 / (sqrt(2π) * sigma)
    norm * exp(-0.5 * z2)
end
### end hidden
### end my answer

function main()
    @assert abs(gaussian_density(0.0, 1.0, 0.0) - 0.398942) < 1.0e-5
    @assert abs(gaussian_density(0.0, 2.0, 1.0) - 0.176033) < 1.0e-5
    @assert abs(gaussian_density(1.0, 3.0, 5.0) - 0.054670) < 1.0e-5
    println("OK")
end

main()
