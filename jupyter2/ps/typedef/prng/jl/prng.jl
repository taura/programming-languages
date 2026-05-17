### begin my answer

### begin hidden
mutable struct Prng
    x :: UInt64
end

mk_prng(seed) = Prng(seed)

function nrand48(rg::Prng)
    y = (0x5DEECE66D * rg.x + 0xB) & ((1 << 48) - 1)
    rg.x = y
    return (y >> 17)
end

### end hidden
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
