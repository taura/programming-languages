### begin my answer

### begin hidden
in_circle(x,y,r) = x*x + y*y <= r*r
### end hidden
### end my answer

function main()
    @assert  in_circle(1, 1, 2)
    @assert  in_circle(3, 4, 6)
    @assert !in_circle(3, 0, 2)
    println("OK")
end

main()
