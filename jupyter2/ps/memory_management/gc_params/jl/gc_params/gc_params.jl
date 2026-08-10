#!/usr/bin/env julia
import Printf

function main()
    argc = length(ARGS)
    s = if argc >= 1 parse(Int64, ARGS[1]) else 1000 * 1000 end
    m = if argc >= 2 parse(Int64, ARGS[2]) else 10 end
    n = if argc >= 3 parse(Int64, ARGS[3]) else m * 10 end
    a = Vector{Vector{Int64}}(undef, m)
    for i = 1:n
        b = Vector{Int64}(undef, s)
        fill!(b, i - 1)
        a[(i - 1) % m + 1] = b
    end
    println("a[1][1] = ", a[1][1])
end

main()


    
