### begin my answer

### begin hidden
function is_leap_year(year)
    if year % 400 == 0
        true
    elseif year % 100 == 0
        false
    elseif year % 4 == 0
        true
    else
        false
    end
end
### end hidden
### end my answer

function main()
    @assert  is_leap_year(2000)
    @assert !is_leap_year(1900)
    @assert  is_leap_year(2024)
    @assert !is_leap_year(2023)
    println("OK")
end

main()
