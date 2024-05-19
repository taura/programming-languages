struct triv{T}
    x :: T
end

function triv_val(t :: triv{<:Any})
    t.x
end

function main()
    s = triv{Int64}(3)
    x = triv_val(s)
    t = triv{String}("hello")
    y = triv_val(t)
    println(x)
    println(y)
end

main()
