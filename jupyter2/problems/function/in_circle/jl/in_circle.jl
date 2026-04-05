### begin my answer

### end my answer

function main()
    @assert  in_circle(1, 1, 2)
    @assert  in_circle(3, 4, 6)
    @assert !in_circle(3, 0, 2)
    println("OK")
end

main()
