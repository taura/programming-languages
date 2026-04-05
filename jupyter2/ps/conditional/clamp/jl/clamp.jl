### begin my answer

### begin hidden
function clamp(x, low, high)
    if x < low
        low
    elseif x > high
        high
    else
        x
    end
end
### end hidden
### end my answer

function main()
    @assert abs(clamp(-3.0, 0.0, 10.0) -  0.0) < 1.0e-5
    @assert abs(clamp( 4.0, 0.0, 10.0) -  4.0) < 1.0e-5
    @assert abs(clamp(15.0, 0.0, 10.0) - 10.0) < 1.0e-5
    println("OK")
end

main()
