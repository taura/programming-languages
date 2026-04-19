function power_iter(a, n)
    p = 1.0
    for i in 1:n
        p *= a
    end
    p
end
### begin my answer

### end my answer

function main()
    @assert abs(power_simple(1.0 + 1/10.0,      10)        - 2.59374246) < 1.0e-7
    @assert abs(power_fast(1.0 + 1/10.0,        10)        - 2.59374246) < 1.0e-7
    @assert abs(power_simple(1.0 + 1/100.0,     100)       - 2.70481383) < 1.0e-7
    @assert abs(power_fast(1.0 + 1/100.0,       100)       - 2.70481383) < 1.0e-7
    @assert abs(power_fast(1.0 + 1/1000000.0,   1000000)   - 2.71828047) < 1.0e-7
    @assert abs(power_iter(1.0 + 1/1000000.0,   1000000)   - 2.71828047) < 1.0e-7
    @assert abs(power_fast(1.0 + 1/10000000.0,  10000000)  - 2.71828169) < 1.0e-7
    @assert abs(power_iter(1.0 + 1/10000000.0,  10000000)  - 2.71828169) < 1.0e-7
    @assert abs(power_fast(1.0 + 1/100000000.0, 100000000) - 2.71828179) < 1.0e-7
    @assert abs(power_iter(1.0 + 1/100000000.0, 100000000) - 2.71828180) < 1.0e-7
    println("OK")
end

main()
