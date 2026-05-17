function affine_recurrence_iter(a, b, c, n)
    x = c
    for i in 1:n
        x = a * x + b
    end
    x
end
### begin my answer

### begin hidden
function affine_recurrence_simple(a, b, c, n)
    if n == 0
        c
    else
        x = affine_recurrence_simple(a, b, c, n - 1)
        a * x + b
    end
end

function affine_recurrence_fast(a, b, c, n)
    if n == 0
        c
    elseif n % 2 == 0
        affine_recurrence_fast(a * a, a * b + b, c, n ÷ 2)
    else
        x = affine_recurrence_fast(a, b, c, n - 1)
        a * x + b
    end
end
### end hidden
### end my answer

function main()
    @assert abs(affine_recurrence_simple(0.9,  1.0, 2.0, 100)     - 9.9997875) < 1.0e-6
    @assert abs(affine_recurrence_simple(0.99, 1.0, 2.0, 1000)    - 99.9957692) < 1.0e-6
    @assert abs(affine_recurrence_fast(0.99,   1.0, 2.0, 1000)    - 99.9957692) < 1.0e-6
    @assert abs(affine_recurrence_fast(0.99,   1.0, 2.0, 10000)   - 100.0) < 1.0e-6
    @assert abs(affine_recurrence_fast(0.999,  1.0, 2.0, 10000)   - 999.9549170) < 1.0e-6
    @assert abs(affine_recurrence_fast(0.999,  1.0, 2.0, 100000)  - 1000.0) < 1.0e-6
    @assert abs(affine_recurrence_fast(0.9999, 1.0, 2.0, 100000)  - 9999.5463184) < 1.0e-6
    @assert abs(affine_recurrence_iter(0.9999, 1.0, 2.0, 100000)  - 9999.5463184) < 1.0e-6
    @assert abs(affine_recurrence_fast(0.9999, 1.0, 2.0, 1000000) - 10000.0) < 1.0e-6
    @assert abs(affine_recurrence_iter(0.9999, 1.0, 2.0, 1000000) - 10000.0) < 1.0e-6
    println("OK")
end

main()
