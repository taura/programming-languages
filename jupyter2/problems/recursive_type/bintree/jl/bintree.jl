### begin my answer

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
