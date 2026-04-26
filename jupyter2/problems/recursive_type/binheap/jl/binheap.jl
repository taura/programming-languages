### begin my answer

### end my answer

## add all values in list xs to tree t in order
function add_seq(xs, t)
    for x in xs
        t = binheap_add(x, t)
    end
    t
end

## remove all values from t and push them in front of xs
function binheap_to_seq(t)
    xs = []
    while t != nothing
        x, t = binheap_remove_min(t)
        push!(xs, x)
    end
    xs
end

## 0 ... n - 1
function range(n)
    collect(0 : n-1)
end

## random sequence
function random_seq(n, x)
    s = []
    for i in 1:n
        x = (0x5DEECE66D * x + 0xB) & 0xFFFFFFFFFFFF
        push!(s, Int(x >> 17))
    end
    s
end

## randomly shuffle xs
function random_shuffle(seed, xs)
    ys = random_seq(length(xs), seed)
    zs = collect(zip(ys, xs))
    sorted_zs = sort(zs, by=first)
    map(last, sorted_zs)
end

## add xs to empty tree; remove all elements from the tree;
## check if they are sorted

function print_vec(header, xs, n)
    print(header, " [")
    for (i, x) in enumerate(xs)
        if i > n
            print("...")
            break
        end
        if i > 1
            print(", ")
        end
        print(x)
    end
    println("]")
end

function check_seq(xs)
    print_vec("input:  ", xs, 7)
    t = add_seq(xs, nothing)
    ys = binheap_to_seq(t)
    print_vec("output: ", ys, 7)
    ys == sort(xs)
end

## randomly shuffle 0 .. n-1;
##   add them to empty tree;
##   remove all elements from the tree;
##   check they are sorted

function check_random(seed, n)
    rng = range(n)
    xs = random_shuffle(seed, rng)
    check_seq(xs)
end

function main()
    seed = 12345
    @assert check_random(seed, 2)
    @assert check_random(seed, 3)
    @assert check_random(seed, 4)
    @assert check_random(seed, 5)
    @assert check_random(seed, 10)
    @assert check_random(seed, 100)
    @assert check_random(seed, 1000)
    @assert check_random(seed, 10000)
    @assert check_random(seed, 100000)
    println("OK")
end

main()
