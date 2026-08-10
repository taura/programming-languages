function get_array_elem(a :: Vector{Float64}, i :: Int64) :: Float64
    a[i]
end

import InteractiveUtils
InteractiveUtils.code_native(get_array_elem)
