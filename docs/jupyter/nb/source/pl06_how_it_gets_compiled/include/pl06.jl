### if label == "add123"
function add123(n :: Int64)
    n + 123
end
### endif
### if label == "many_args"
function many_args(a00 :: Int64, a01 :: Int64, a02 :: Int64, a03 :: Int64,
                   a04 :: Int64, a05 :: Int64, a06 :: Int64, a07 :: Int64,
                   a08 :: Int64, a09 :: Int64, a10 :: Int64, a11 :: Int64)
    a00 + a01 + a02 + a03 + a04 + a05 + a06 + a07 + a08 + a09 + a10 + a11
end
### endif
### if label == "add_floats"
function add_floats(x :: Float64, y :: Float64)
    x + y
end
### endif
### if label == "get_float_array_elem"
function get_float_array_elem_const(a :: Vector{Float64})
    a[2]
end
function get_float_array_elem_i(a :: Vector{Float64}, i :: Int64)
    a[i]
end
### endif
### if label == "get_struct_elem"
struct Point
    x :: Float64
    y :: Float64
end
function get_point_y(p :: Point)
    p.y
end
### endif
### if label == "collatz"
function collatz(n :: Int64)
  if n % 2 == 0
      div(n, 2)
  else
      3 * n + 1
  end
end
### endif
### if label == "regions"
function regions(n :: Int64)
    if n == 0
        1
    else
        regions(n - 1) + n - 1
    end
end
### endif
### if label == "sum_array_rec"
function sum_array_rec(a :: Vector{Float64}, p :: Int64, q :: Int64)
    if q - p == 0
        0.0
    elseif q - p == 1
        a[p]
    else
        r = (p + q) / 2
        sum_array_rec(a, p, r) + sum_array_rec(a, r, q)
    end
end
### endif
### if label == "regions_tail"
function regions_tail(i :: Int64, n :: Int64, ri :: Int64)
    if i == n
        ri
    else
        riplus1 = ri + i + 1
        regions_tail(i + 1, n, riplus1)
    end
end
### endif
### if label == "sum_array_tail_rec"
function sum_array_tail_rec(a :: Vector{Float64}, i :: Int64, n :: Int64, s :: Float64)
    if i == n
        s
    else
        sum_array_tail_rec(a, i + 1, n, s + a[i])
    end
end
### endif
### if label == "sum_array_loop"
function sum_array_loop(a :: Vector{Float64}, n :: Int64)
    s = 0.0
    for i = 1:n
        s += a[i];
    end
    return s
end
### endif
### if 0
using InteractiveUtils
code_native(add123)
code_native(many_args)
code_native(add_floats)
code_native(get_float_array_elem_const)
code_native(get_float_array_elem_i)
code_native(get_point_y)
code_native(collatz)
code_native(regions)
code_native(regions_tail)
code_native(sum_array_loop)
code_native(sum_array_tail_rec)
code_native(sum_array_rec)
### endif
