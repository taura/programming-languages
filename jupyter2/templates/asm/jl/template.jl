### (1)

function add_nums(x :: Int64, y :: Int64) :: Int64
    x + y + 123
end

function add_ints(x :: Int64, y :: Int64) :: Int64
    x + y + 123
end

function add_floats(x :: Float64, y :: Float64) :: Float64
    x + y + 123.0
end

### (2)

struct Point
    x :: Float64
    y :: Float64
end

function get_point_y(p :: Point) :: Float64
    p.y
end

### (3)
function get_float_array_elem_const(a :: Vector{Float64}) :: Float64
    a[3]
end

function get_float_array_elem_var(a :: Vector{Float64}, i :: Int64) :: Float64
    a[i]
end

### (4)

function collatz(n :: Int64) :: Int64
    if n % 2 == 0
        n ÷ 2                   # integer division (= div(n, 2))
    else
        3 * n + 1
    end
end

function gcd1(a :: Int64, b :: Int64) :: Int64
    if b == 0
        a
    else
        a % b
    end
end

### (5)

function sum_array_loop(a :: Vector{Float64}, n :: Int64) :: Float64
    s = 0.0
    for i in 1:n
        s += a[i]
    end
    return s
end

### (6)

function call_tanh(x :: Float64) :: Float64
    tanh(x + 1.0) + x
end

### (7)

function sum_array_rec(a :: Vector{Float64}, n :: Int64) :: Float64
    if n == 0
        return 0.0
    else
        return sum_array_rec(a, n - 1) + a[n]
    end
end

### (8)

function sum_array_tail(a :: Vector{Float64}, i :: Int64, n :: Int64, s :: Float64) :: Float64
    if i == n
        return s
    else
        return sum_array_tail(a, i + 1, n, s + a[i])
    end
end

### (9)

function mk_point(x :: Float64, y :: Float64) :: Point
    Point(x + 1.0, y + 2.0)
end

### (10)

function mkVector(x :: Float64) :: Vector{Float64}
    [x, x, x, x, x, x, x, x, x, x]
end

### (11)

abstract type Shape end

function call_area(s :: Shape) :: Float64
    area(s)
end

###

import InteractiveUtils
function assemble(f)
    InteractiveUtils.code_native(f)
end

assemble(add_ints)
assemble(add_floats)
assemble(get_point_y)
assemble(get_float_array_elem_const)
assemble(get_float_array_elem_var)
assemble(collatz)
assemble(gcd1)
assemble(sum_array_loop)
assemble(call_tanh)
assemble(sum_array_rec)
assemble(sum_array_tail)
assemble(mk_point)
assemble(mkVector)
assemble(call_area)

