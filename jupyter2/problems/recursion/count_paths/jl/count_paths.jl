### begin my answer

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
