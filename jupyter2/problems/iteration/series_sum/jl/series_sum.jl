### begin my answer

### end my answer

function main()
    a = pi * pi / 6.0
    @assert abs(series_sum(10) - 1.549768) < 1.0e-5
    @assert abs(series_sum(100000) - a) < 1.0e-5
    @assert abs(series_sum(1000000) - a) < 1.0e-6
    @assert abs(series_sum(20000000) - a) < 1.0e-6
    println("OK")
end

main()
