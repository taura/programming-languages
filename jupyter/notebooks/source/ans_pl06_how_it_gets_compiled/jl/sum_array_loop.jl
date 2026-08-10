
function sum_array_loop(a :: Vector{Float64}, n :: Int64)
    s = 0.0
    for i = 1:n
        s += a[i];
    end
    return s
end
