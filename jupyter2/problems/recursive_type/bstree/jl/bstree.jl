### begin my answer

### end my answer

function insert_seq(xs, t)
    for x in xs
        t = insert(x, t)
    end
    t
end

function random_seq(n, seed)
    x = seed
    xs = Vector{Int}()
    for i in 1:n
        x = (0x5DEECE66D * x + 0xB) & 0xFFFFFFFFFFFF
        push!(xs, x >> 17)
    end
    xs
end

function check_seq(xs, m)
    t = insert_seq(xs, nothing)
    sorted = sort(xs)
    nth(m, t) == sorted[m + 1]
end

function check_random(seed, n, m)
    xs = random_seq(n, seed)
    check_seq(xs, m)
end

function main()
    @assert(check_seq([1,2,4,0,3], 2))
    @assert(check_random(123,     10,     3))
    @assert(check_random(123,    100,    40))
    @assert(check_random(123,   1000,   500))
    @assert(check_random(123,  10000,  6000))
    @assert(check_random(123, 100000, 70000))
    println("OK")
end

main()
