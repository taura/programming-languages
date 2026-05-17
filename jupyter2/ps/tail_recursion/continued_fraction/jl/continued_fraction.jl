### begin my answer

### begin hidden
function continued_fraction_tail_rec(a, m, xm, n)
    if m == n
        xm
    else
        xm_1 = 1 / (a + xm)
        continued_fraction_tail_rec(a, m + 1, xm_1, n)
    end
end

continued_fraction_tail(a, n) = continued_fraction_tail_rec(a, 0, 1.0, n)

### end hidden
### end my answer

function main()
    @assert abs(continued_fraction_tail(2.0, 100) - 0.4142136) < 1.0e-6
    @assert abs(continued_fraction_tail(3.0, 100) - 0.3027756) < 1.0e-6
    @assert abs(continued_fraction_tail(4.0, 100) - 0.2360680) < 1.0e-6
    println("OK")
end

main()
