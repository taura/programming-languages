### begin my answer

### begin hidden
function affine_recurrence_simple_tail_rec(a, b, m, xm, n)
    if m == n
        xm
    else
        xm_1 = a * xm + b
        affine_recurrence_simple_tail_rec(a, b, m + 1, xm_1, n)
    end
end

affine_recurrence_simple_tail(a, b, c, n) = affine_recurrence_simple_tail_rec(a, b, 0, c, n)

function affine_recurrence_fast_tail_rec(a, b, m, xm, n)
    if m == n
        xm
    elseif (n - m) % 2 == 0
        affine_recurrence_fast_tail_rec(a * a, a * b + b, m, xm, div(m + n, 2))
    else
        xm_1 = a * xm + b
        affine_recurrence_fast_tail_rec(a, b, m + 1, xm_1, n)
    end
end

affine_recurrence_fast_tail(a, b, c, n) = affine_recurrence_fast_tail_rec(a, b, 0, c, n)
### end hidden
### end my answer

function main()
    @assert abs(affine_recurrence_fast_tail(0.9999,   1.0, 2.0, 100000)  - 9999.5463184) < 1.0e-6
    @assert abs(affine_recurrence_simple_tail(0.9999, 1.0, 2.0, 100000)  - 9999.5463184) < 1.0e-6
    @assert abs(affine_recurrence_fast_tail(0.9999,   1.0, 2.0, 1000000) - 10000.0) < 1.0e-6
    @assert abs(affine_recurrence_simple_tail(0.9999, 1.0, 2.0, 500000)  - 10000.0) < 1.0e-6
    println("OK")
end

main()
