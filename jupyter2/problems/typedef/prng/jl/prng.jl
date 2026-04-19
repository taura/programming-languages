### begin my answer

### end my answer

function main()
    # @assert ...
    rg = mk_prng(112233445566778899)
    @assert nrand48(rg) == 1781099660
    @assert nrand48(rg) == 328479882
    @assert nrand48(rg) == 1084899894
    @assert nrand48(rg) == 1228799231
    @assert nrand48(rg) == 2081468441
    println("OK")
end

main()
