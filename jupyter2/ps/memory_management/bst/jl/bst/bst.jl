#!/usr/bin/env julia
# ------------- random number generator -------------

"""
random number generator state
"""
mutable struct RandState
    x :: UInt64
end

"""
next number
"""
function next(rg :: RandState)
    x = rg.x
    a = UInt64(0x5DEECE66D)
    c = UInt64(0xB)
    m = UInt64(2)^48 - 1
    rg.x = (a * x + c) & m
    rg.x >> 17
end

# ------------- binary search tree -------------

"""
binary search tree
"""
mutable struct BinSearchTree
    val :: UInt64
    lc :: UInt64
    left :: Union{BinSearchTree,Nothing}
    rc :: UInt64
    right :: Union{BinSearchTree,Nothing}
end

"""
insert x to an empty tree
"""
function insert(t :: Nothing, val :: UInt64)
    BinSearchTree(val, 0, nothing, 0, nothing)
end

"""
insert x to a non-empty tree
"""
function insert(t :: BinSearchTree, val :: UInt64)
    if val <= t.val
        BinSearchTree(t.val, t.lc + 1, insert(t.left, val), t.rc, t.right)
    else
        BinSearchTree(t.val, t.lc, t.left, t.rc + 1, insert(t.right, val))
    end
end

"""
remove the n-th smallest element from a tree
"""
function remove_nth(t :: Nothing, n :: UInt64)
    error("remove_nth : empty tree")
end

function remove_nth(t :: BinSearchTree, n :: UInt64)
    if n < t.lc
        val, left_ = remove_nth(t.left, n)
        val, BinSearchTree(t.val, t.lc - 1, left_, t.rc, t.right)
    elseif n == t.lc
        if t.lc < t.rc
            val, right_ = remove_nth(t.right, UInt64(0))
            t.val, BinSearchTree(val, t.lc, t.left, t.rc - 1, right_)
        elseif t.left != nothing
            val, left_ = remove_nth(t.left, t.lc - 1)
            t.val, BinSearchTree(val, t.lc - 1, left_, t.rc, t.right)
        else
            t.val, nothing
        end
    else
        val, right_ = remove_nth(t.right, n - t.lc - 1)
        val, BinSearchTree(t.val, t.lc, t.left, t.rc - 1, right_)
    end
end

"""
dump first n elements of the tree
"""
function dump(t :: Nothing, n :: UInt64)
    nothing
end

function dump(t :: BinSearchTree, n :: UInt64)
    if t != nothing && n > 0
        dump(t.left, n)
        if t.lc < n
            print(t.val, " ")
            if t.lc + 1 < n
                dump(t.right, n - t.lc - 1)
            end
        end
    end
end

function main()
    println("lang = julia")
    argc = length(ARGS)
    m = if argc >= 1 parse(Int64, ARGS[1]) else 100 * 1000 end
    n = if argc >= 2 parse(Int64, ARGS[2]) else div(m, 2) end
    rg = RandState(123456)
    println("make a tree of m = ", m, " nodes")
    t = nothing
    # make a tree of m nodes
    for i = 1:m
        x = next(rg) % 1000000000
        t = insert(t, x)
    end
    println("insert/delete n = ", n, " times")
    t0 = time_ns()
    # repeat n times removing an element and inserting another
    for i = 1:n
        x = next(rg) % 1000000000
        k = next(rg) % (m + 1)
        t = insert(t, x)
        v, t = remove_nth(t, k)
    end
    t1 = time_ns()
    print("dump the first 5 elements in the tree : ")
    dump(t, UInt64(5))
    println("")
    println("took ", (t1 - t0), " nsec to insert/remove ", n, " elements (", (t1 - t0) / n, " nsec/elem)")
end

main()


    
