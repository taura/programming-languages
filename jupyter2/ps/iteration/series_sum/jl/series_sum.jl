### begin my answer

### begin hidden
function series_sum(n)
    s = 0.0
    for k in 1:n
        s += 1.0 / (k * k)
    end
    s
end
### end hidden
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
