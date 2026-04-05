### begin my answer

### begin hidden
sigmoid(x) = 1 / (1 + exp(-x))
### end hidden
### end my answer

function main()
    @assert abs(sigmoid(-5.0) - 0.00669) < 1e-5
    @assert abs(sigmoid(-0.5) - 0.37754) < 1e-5
    @assert abs(sigmoid( 0.0) - 0.5) < 1e-5
    @assert abs(sigmoid(10.0) - 0.999954) < 1e-5
    println("OK")
end

main()
