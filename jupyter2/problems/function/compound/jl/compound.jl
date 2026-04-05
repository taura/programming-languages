### begin my answer

### end my answer

function main()
    @assert abs(compound(100, 0.1, 2) - 121) < 1e-5
    @assert abs(compound(100, 0.2, 5) - 248.832) < 1e-5
    @assert abs(compound(100, 0.3, 10) - 1378.584918) < 1e-5
    619.173642
    println("OK")
end

main()
