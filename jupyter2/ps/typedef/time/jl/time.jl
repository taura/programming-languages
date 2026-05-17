### begin my answer

### begin hidden
struct Time
    hour::Int
    minute::Int
    second::Float64
end

second_of_time(t::Time) = t.hour * 3600 + t.minute * 60 + t.second

function time_diff(a::Time, b::Time)
    abs(second_of_time(a) - second_of_time(b))
end
### end hidden
### end my answer

function main()
    @assert abs(time_diff(Time(12, 0, 0.), Time(11, 30, 0.)) - 1800.) < 1e-6
    @assert abs(time_diff(Time(23, 59, 59.9), Time(0, 0, 0.)) - 86399.9) < 1e-6
    println("OK")
end

main()
