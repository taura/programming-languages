### begin my answer

### begin hidden
struct BinHeap
    x :: Int
    lc :: Int
    l :: Union{Nothing, BinHeap}
    rc :: Int
    r :: Union{Nothing, BinHeap}
end

function complete_bintree(n :: Int)
    (n & (n + 1)) == 0
end

binheap_add(x :: Int, t::Nothing) = BinHeap(x, 0, nothing, 0, nothing)

function binheap_add(x :: Int, t::BinHeap)
    y = t.x
    lc = t.lc
    l = t.l
    rc = t.rc
    r = t.r
    @assert lc >= rc
    u, v = if x < y
        x, y
    else
        y, x
    end
    if complete_bintree(lc) && lc > rc
        # left is perfect; add to right
        BinHeap(u, lc, l, rc + 1, binheap_add(v, r))
    else
        # add to left
        BinHeap(u, lc + 1, binheap_add(v, l), rc, r)
    end
end
    
function binheap_remove_rightmost_leaf(t::Nothing)
    (-1, nothing)
end

function binheap_remove_rightmost_leaf(t::BinHeap)
    if t.lc == 0 && t.rc == 0
        (t.x, nothing)
    elseif complete_bintree(t.lc) && t.lc < 2 * t.rc + 1
        # remove from right
        y, r_ = binheap_remove_rightmost_leaf(t.r)
        @assert y != -1
        (y, BinHeap(t.x, t.lc, t.l, t.rc - 1, r_))
    else
        # remove from left
        y, l_ = binheap_remove_rightmost_leaf(t.l)
        (y, BinHeap(t.x, t.lc - 1, l_, t.rc, t.r))
    end
end
    
function binheap_remove_rightmost_leaf(t::BinHeap)
    if t.lc == 0 && t.rc == 0
        (t.x, nothing)
    elseif complete_bintree(t.lc) && t.lc < 2 * t.rc + 1
        # remove from right
        y, r_ = binheap_remove_rightmost_leaf(t.r)
        @assert y != -1
        (y, BinHeap(t.x, t.lc, t.l, t.rc - 1, r_))
    else
        # remove from left
        y, l_ = binheap_remove_rightmost_leaf(t.l)
        (y, BinHeap(t.x, t.lc - 1, l_, t.rc, t.r))
    end
end
    
function binheap_fix(t::Nothing)
    nothing
end

function binheap_fix(t::BinHeap)
    if t.lc == 0 && t.rc == 0
        t
    elseif t.lc == 1 && t.rc == 0
        y = t.l.x
        u, v = if t.x < y
            t.x, y
        else
            y, t.x
        end
        BinHeap(u, 1, BinHeap(v, 0, nothing, 0, nothing), 0, nothing)
    else
        lx = t.l.x
        rx = t.r.x
        if t.x < lx && t.x < rx
            # x is already root
            t
        elseif lx < rx
            # lx should be root x <-> lx
            BinHeap(lx, t.lc, binheap_fix(BinHeap(t.x, t.l.lc, t.l.l, t.l.rc, t.l.r)), t.rc, t.r)
        else
            # rx should root x <-> ly
            BinHeap(rx, t.lc, t.l, t.rc, binheap_fix(BinHeap(t.x, t.r.lc, t.r.l, t.r.rc, t.r.r)))
        end
    end
end

function binheap_remove_min(t)
    x, t = binheap_remove_rightmost_leaf(t)
    if x == -1
        (-1, nothing)
    elseif t == nothing
        (x, nothing)
    else
        (t.x, binheap_fix(BinHeap(x, t.lc, t.l, t.rc, t.r)))
    end
end

### end hidden
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
