### if label == "A simple recurrence"
function a(n)
    if n == 0
        1
    else
        0.9 * a(n - 1) + 2
    end
end
### endif
### if label == "A simple recurrence test"
function float64_close(x, y, eps)
    if abs(x - y) > eps
        println("NG")
    else
        println("OK")
    end
end
### if 0
function a_test()
### endif
    float64_close(a(0),   1,          1.0e-6)
    float64_close(a(10),  13.3751096, 1.0e-6)
    float64_close(a(100), 19.9994953, 1.0e-6)
    float64_close(a(300), 20.0,       1.0e-6)
### if 0
end
### endif
### endif
### if label == "The smallest divisor"
function smallest_divisor_geq(n, x)
    if n % x == 0
        x
    elseif n < x * x
        n
    else
        smallest_divisor_geq(n, x + 1)
    end
end
### endif
### if label == "The smallest divisor test"
function int64_eq(x, y)
    if x == y
        println("OK")
    else
        println("NG")
    end
end
### if 0
function smallest_divisor_geq_test()
### endif
    int64_eq(smallest_divisor_geq(2,          2), 2)
    int64_eq(smallest_divisor_geq(3,          2), 3)
    int64_eq(smallest_divisor_geq(13 * 17,    2), 13)
    int64_eq(smallest_divisor_geq(6700417, 2), 6700417)
### if 0
end
### endif
### endif
### if label == "Factorize"
function factorize(n)
    if n == 1
        []
    else
        x = smallest_divisor_geq(n, 2)
        a = factorize(n / x)
        vcat(x, a)
    end
end
### endif
### if label == "Factorize test"
function int64_list_eq(a, b)
    if a == b
        println("OK")
    else
        println("NG")
    end
end
### if 0
function factorize_test()
### endif
    int64_list_eq(factorize(64), [2, 2, 2, 2, 2, 2])
    int64_list_eq(factorize(105), [3, 5, 7])
### if 0
end
### endif
### endif
### if label == "Subset sum"
function subset_sum(a, v)
    if v == 0
        return zeros(Int64, length(a))
    elseif v < 0 || length(a) == 0
        return nothing
    end
    k1 = subset_sum(a[2:end], v - a[1])
    if k1 != nothing
        return vcat([1], k1)
    end
    k0 = subset_sum(a[2:end], v)
    if k0 != nothing
        return vcat([0], k0)
    end
    nothing
end
### endif
### if label == "Subset sum test"
### if 0
function subset_sum_test()
### endif
    int64_list_eq(subset_sum([1,2,3,4,5], 8), [1, 1, 0, 0, 1])
    int64_list_eq(subset_sum([33, 28, 56, 35, 19, 46, 25, 58, 17, 49, 33, 39, 37, 33, 24, 52], 233),
                  [1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0])
    int64_list_eq(subset_sum([30, 37, 46, 41, 14, 46, 44, 40, 46, 30, 46, 28, 33, 31, 56], 171),
                  [1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0])
    int64_list_eq(subset_sum([47, 39, 15, 27, 52, 31, 39, 54, 20, 26, 38, 19, 35, 28], 440), nothing)
    int64_list_eq(subset_sum([16, 24, 13, 20, 24, 13, 11, 31, 29, 44], 222), nothing)
### if 0
end
### endif
### endif
### if label == 0
function main()
    println("a")
    a_test()
    println("smallest_divisor_geq")
    smallest_divisor_geq_test()
    println("factorize")
    factorize_test()
    println("subset_sum_test")
    subset_sum_test()
end
main()
### endif
