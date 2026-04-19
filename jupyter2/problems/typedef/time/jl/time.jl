### begin my answer

### end my answer

function main()
    @assert abs(time_diff(Time(12, 0, 0.), Time(11, 30, 0.)) - 1800.) < 1e-6
    @assert abs(time_diff(Time(23, 59, 59.9), Time(0, 0, 0.)) - 86399.9) < 1e-6
    println("OK")
end

main()
