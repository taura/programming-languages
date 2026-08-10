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
### if label == "measure_time"
        t0 = time_ns()
### endif
        b = fill(0, s)
### if label in [ "show_addr", "measure_time" ]
        p = pointer(b)
### endif
        a[(i - 1) % m + 1] = b
### if label == "measure_time"
        t1 = time_ns()
### endif
### if label == "show_addr"
        Printf.@printf("%ld\t%ld\n", i, Int64(p))
### endif
### if label == "measure_time"
        Printf.@printf("%ld\t%ld\t%ld\n", i, Int64(p), t1 - t0)
### endif
    end
end

main()
