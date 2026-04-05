### begin my answer

### begin hidden
function gcd(a, b)
    while b != 0
        a, b = b, a % b
    end
    a
end
### end hidden
### end my answer

function main()
    @assert gcd(1499276220, 463728183) == 6873
    @assert gcd(256381708674, 48941846742) == 35094
    @assert gcd(8619803849, 3861314192) == 11437
    println("OK")
end

main()
