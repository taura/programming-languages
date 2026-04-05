### begin my answer

### end my answer

function main()
    @assert abs(find_root(0, 2, 1.0e-20) - 1.5213797) < 1.0e-6
    println("OK")
end

main()
