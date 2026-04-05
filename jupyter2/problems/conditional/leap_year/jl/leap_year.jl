### begin my answer

### end my answer

function main()
    @assert  is_leap_year(2000)
    @assert !is_leap_year(1900)
    @assert  is_leap_year(2024)
    @assert !is_leap_year(2023)
    println("OK")
end

main()
