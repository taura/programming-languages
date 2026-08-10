# ------------ this is only for recording (nothing to do with binary search tree) ------------

"""
allocation record that records how long an allocation took
"""
struct Event
    stamp :: Int64              # when it happened
    dt :: Int64                 # how long it took
end

"""
heap data structure that keeps track of longest m allocations
(this heap should not be confused with heap memory of programming languages).
"""
mutable struct EventHeap
    n :: Int64                # actual no of elements in a
    a :: Vector{Event}        # vector of m elements
    # invariant a[p] < a[2p], a[p] < a[2p+1]
    start_stamp :: UInt64
end

"""
create a heap of m Events
"""
function mkHeap(m :: Int64)
    EventHeap(0, [Event(0, 0) for i in 1:m], time_ns())
end

"""
add an element x to heap h
"""
function add(h :: EventHeap, x :: Event)
    n, a = h.n, h.a
    @assert n < length(a)
    n = n + 1
    a[n] = x
    c = n
    while c > 1
        p = div(c, 2)
        if a[c].dt < a[p].dt
            a[c], a[p] = a[p], a[c]
        end
        c = p
    end
    h.n = n
end

"""
remove the smallest element from h
"""
function removeSmallest(h :: EventHeap)
    n, a = h.n, h.a
    @assert n > 0
    x = a[1]
    a[1] = a[n]
    n = n - 1
    p = 1
    while 2p <= n
        if 2p + 1 <= n && a[2p+1].dt < a[2p].dt
            c = 2p + 1
        else
            c = 2p
        end
        if a[c].dt < a[p].dt
            a[c], a[p] = a[p], a[c]
        end
        p = c
    end
    h.n = n
    x
end

"""
add an allocation record to h;
if h has a room for another element, insert Event(stamp, dt)
otherwise if dt is larger than the smallest dt in h, then
replace it with Event(stamp, dt)
"""
function addRecord(h :: EventHeap, dt :: UInt64)
    m = length(h.a)
    if h.n == m && h.a[1].dt < dt
        removeSmallest(h)
    end
    if h.n < m
        stamp = time_ns() - h.start_stamp
        add(h, Event(stamp, dt))
    end
end

"""
debugprint heap
"""
function printHeap(h :: EventHeap, filename :: String)
    open(filename, "w") do wp
        # println(wp, "stamp,dt")
        for i = 1:h.n
            e = removeSmallest(h)
            println(wp, e.stamp, ",", e.dt)
        end
    end
end

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
    left :: Union{BinSearchTree,Nothing}
    right :: Union{BinSearchTree,Nothing}
end

function mkBinSearchTree(val, left, right)
    t = BinSearchTree(val, left, right)
    println(Int64(Int64(pointer_from_objref(t))))
    t
end

"""
insert x to an empty tree
"""
function insert(t :: Nothing, val :: UInt64)
    mkBinSearchTree(val, nothing, nothing)
end

"""
insert x to a non-empty tree
"""
function insert(t :: BinSearchTree, val :: UInt64)
    if val <= t.val
        mkBinSearchTree(t.val, insert(t.left, val), t.right)
    else
        mkBinSearchTree(t.val, t.left, insert(t.right, val))
    end
end

"""
remove the maximum element from a tree
"""
function remove_max(t :: BinSearchTree)
    if t.right == nothing
        t.left
    else
        mkBinSearchTree(t.val, t.left, remove_max(t.right))
    end
end

"""
find the maximum element of a tree
"""
function peek_max(t :: BinSearchTree)
    if t.right == nothing
        t.val
    else
        peek_max(t.right)
    end
end

function main()
    println("lang = julia")
    argc = length(ARGS)
    m = if argc >= 1 parse(Int64, ARGS[1]) else 100 * 1000 end
    n = if argc >= 2 parse(Int64, ARGS[2]) else div(m, 2) end
    n_records = if argc >= 3 parse(Int64, ARGS[3]) else max(div(n, 1000), 100) end
    rg = RandState(123456)
    println("make a tree of m = ", m, " nodes")
    t = nothing
    # make a tree of m nodes
    for i = 1:m
        x = next(rg) % 1000000000
        t = insert(t, x)
    end
    println("insert/delete n = ", n, " times")
    h = mkHeap(n_records)
    t0 = time_ns()
    # repeat n times removing an element and inserting another
    for i = 1:n
        x = next(rg) % 1000000000
        s0 = time_ns() 
        t = insert(t, x)
        t = remove_max(t)
        s1 = time_ns()
        addRecord(h, s1 - s0)
    end
    t1 = time_ns()
    if t == nothing
        println()
    else
        v = peek_max(t)
        println(m, " th smallest value out of ", (m + n), " values v = ", v)
    end
    println("took ", (t1 - t0), " nsec to insert/remove ", n, " elements")
    alloc_log = "allocation-julia.csv"
    println("dump ", n_records, " records that took longest to ", alloc_log)
    printHeap(h, alloc_log)
end

main()


    
