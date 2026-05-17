### begin my answer

### begin hidden
struct BinTree
    left
    right
end

function mk_maximally_balanced_bintree(n::Int)
    if n == 0
        nothing
    else
        ls = div(n, 2)
        rs = n - 1 - ls
        l = mk_maximally_balanced_bintree(ls)
        r = mk_maximally_balanced_bintree(rs)
        BinTree(l, r)
    end
end

function count_nodes(t::Nothing)
    0
end

function count_nodes(t::BinTree)
    lc = count_nodes(t.left)
    rc = count_nodes(t.right)
    if lc != -1 && rc != -1 && (lc == rc || lc == rc + 1)
        1 + lc + rc
    else
        -1
    end
end
### end hidden
### end my answer

function main()
    @assert(count_nodes(mk_maximally_balanced_bintree(10))      == 10)
    @assert(count_nodes(mk_maximally_balanced_bintree(100))     == 100)
    @assert(count_nodes(mk_maximally_balanced_bintree(1000))    == 1000)
    @assert(count_nodes(mk_maximally_balanced_bintree(10000))   == 10000)
    @assert(count_nodes(mk_maximally_balanced_bintree(100000))  == 100000)
    @assert(count_nodes(mk_maximally_balanced_bintree(1000000)) == 1000000)
    println("OK")
end

main()
