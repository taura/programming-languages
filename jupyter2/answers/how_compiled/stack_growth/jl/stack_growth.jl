function sum_array_loop(a :: Vector{Float64}, n :: Int64) :: Float64
    s = 0.0
    for i in 1:n
        s += a[i]
    end
    return s
end

import InteractiveUtils
InteractiveUtils.code_native(sum_array_loop)
