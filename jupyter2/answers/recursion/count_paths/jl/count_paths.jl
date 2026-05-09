### begin my answer

function count_paths(a, b)
    if a == 0 || b == 0
        1
    else
        count_paths(a - 1, b) + count_paths(a, b - 1)
    end
end

function count_paths_below_rec(p, q, a, b)
    if p == 0 || q == 0
        1
    elseif -b * p + a * q > 0
        0
    else
        count_paths_below_rec(p - 1, q, a, b) + count_paths_below_rec(p, q - 1, a, b)
    end
end

function count_paths_below(a, b)
    count_paths_below_rec(a, b, a, b)
end

### end my answer

function main()
    @assert count_paths(7, 3)         == 120
    @assert count_paths_below(7, 3)   == 12
    @assert count_paths(12, 8)        == 125970
    @assert count_paths_below(12, 8)  == 7229
    @assert count_paths(17, 13)       == 119759850
    @assert count_paths_below(17, 13) == 3991995
    println("OK")
end

main()
