### begin my answer

### begin hidden
function find_root(a, b, eps)
    f(x) = x^3 - x - 2
    l = a
    r = b
    while abs(r - l) > eps
        c = 0.5 * (l + r)
        if f(l) * f(c) < 0
            r = c
        else
            l = c
        end
    end
    0.5 * (l + r)
end
### end hidden
### end my answer

function main()
    @assert abs(find_root(0, 2, 1.0e-20) - 1.5213797) < 1.0e-6
    println("OK")
end

main()
