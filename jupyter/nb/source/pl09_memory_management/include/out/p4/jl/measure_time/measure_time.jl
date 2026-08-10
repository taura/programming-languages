import Printf

function main()
    argc = length(ARGS)
    s = if argc >= 1 parse(Int64, ARGS[1]) else 1000 * 1000 end
    m = if argc >= 2 parse(Int64, ARGS[2]) else 100 end
    n = if argc >= 3 parse(Int64, ARGS[3]) else m * 10 end
    if sizeof(Int64) * s * m > (1 << 30)
        Printf.@printf("you'd better not allocate that much memory")
        Printf.@printf("sizeof element(8) * s(%d) * m(%d) = %d > 1GB\n", s, m, sizeof(Int64) * s * m)
        exit(1)
    end
    a = Vector{Vector{Int64}}(undef, m)
    for i = 1:n
        t0 = time_ns()
        b = fill(0, s)
        p = pointer(b)
        a[(i - 1) % m + 1] = b
        t1 = time_ns()
        Printf.@printf("%ld\t%ld\t%ld\n", i, Int64(p), t1 - t0)
    end
end

main()
