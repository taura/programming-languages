function sum_array_tail(a :: Vector{Float64}, i :: Int64, n :: Int64, s :: Float64) :: Float64
    if i > n
        return s
    else
        return sum_array_tail(a, i + 1, n, s + a[i])
    end
end

import InteractiveUtils
InteractiveUtils.code_native(sum_array_tail)
