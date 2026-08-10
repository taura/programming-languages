# begin my answer

# begin hidden
# non-empty two-three-tree
# leaf : length(keys) == 1, children == nil
# N2 : length(keys) == 1, length(children) == 2
# N3 : length(keys) == 2, length(children) == 3
struct TTTree_
    keys
    children
end

function leaf(x)
    TTTree_(Int[x], nothing)
end

function n2(u0, s0, u1)
    TTTree_(Int[s0], [u0, u1])
end

function n3(u0, s0, u1, s1, u2)
    TTTree_(Int[s0, s1], [u0, u1, u2])
end

function is_leaf(t)
    t.children === nothing
end

# empty : nil
# singleton : t = nil
# tree : t != nil
struct TTTree
    key
    t
end

function singleton(x)
    TTTree(x, nothing)
end

function tree(t)
    TTTree(-1, t)
end

function is_empty(t)
    t === nothing
end

function is_singleton(t)
    t.t === nothing
end

#= check if all leaves have the same depth and all internal nodes have the correct number of children (2 or 3)
   and returns the depth of the tree if it is a valid two-three-tree =#
function tttree_check_(t)
    if is_leaf(t)       # leaf
        0
    else
        n = length(t.children)
        d = tttree_check_(t.children[1])
        for i in 2:n
            d_ = tttree_check_(t.children[i])
            if d_ != d; error("assert all children have the same depth"); end
        end
        d + 1
    end
end

function _tttree_check(t)
    if is_empty(t)          # empty
        0
    elseif is_singleton(t)  # singleton
        1
    else                    # tree
        tttree_check_(t.t)
    end
end

function tttree_print_(t, depth)
    if is_leaf(t)
        print(repeat(" ", depth), "Leaf(", t.keys[1], ")\n")
        0
    else
        print(repeat(" ", depth), "Node(")
        n = length(t.children)
        for i in 1:n-1
            if i > 1
                print("|")
            end
            print(t.keys[i])
        end
        print(") [\n")
        d = tttree_print_(t.children[1], depth + 1)
        for i in 2:n
            d_ = tttree_print_(t.children[i], depth + 1)
            if d_ != d; error("assert all children have the same depth"); end
        end
        print(repeat(" ", depth), "]\n")
        d + 1
    end
end

function tttree_check(t)
    if is_empty(t)
        #println("Empty")
        0
    elseif is_singleton(t)
        #println("Singleton(", t.key, ")")
        1
    else
        tttree_check_(t.t)
    end
end

# return
# (nil, c0, s0, c1) or
# (t', nil, -1, nil)
function tttree_add_(x, t)
    if is_leaf(t)
        y = t.keys[1]
        u, v = min(x, y), max(x, y)
        nothing, leaf(u), v, leaf(v)
    elseif length(t.children) == 2
        #    s0
        # u0    u1
        s0 = t.keys[1]
        u0, u1 = t.children[1], t.children[2]
        if x < s0
            u0_, u00, s00, u01 = tttree_add_(x, u0)
            if u0_ === nothing
                #     s00     s0
                # u00     u01    u1
                n3(u00, s00, u01, s0, u1), nothing, -1, nothing
            else
                n2(u0_, s0, u1), nothing, -1, nothing
            end
        else
            u1_, u10, s10, u11 = tttree_add_(x, u1)
            if u1_ === nothing
                #    s0     s10
                # u0    u10     u11
                n3(u0, s0, u10, s10, u11), nothing, -1, nothing
            else
                n2(u0, s0, u1_), nothing, -1, nothing
            end
        end
    elseif length(t.children) == 3
        s0, s1 = t.keys[1], t.keys[2]
        u0, u1, u2 = t.children[1], t.children[2], t.children[3]
        if x < s0
            u0_, u00, s00, u01 = tttree_add_(x, u0)
            if u0_ === nothing
                #     s00
                # u00     s0     s1
                #     u01     u1    u2
                nothing, n2(u00, s00, u01), s0, n2(u1, s1, u2)
            else
                n3(u0_, s0, u1, s1, u2), nothing, -1, nothing
            end
        elseif x < s1
            u1_, u10, s10, u11 = tttree_add_(x, u1)
            if u1_ === nothing
                #    s0     s10      s1
                # u0    u10      u11    u2
                nothing, n2(u0, s0, u10), s10, n2(u11, s1, u2)
            else
                n3(u0, s0, u1_, s1, u2), nothing, -1, nothing
            end
        else
            u2_, u20, s20, u21 = tttree_add_(x, u2)
            if u2_ === nothing
                #    s0    s1     s21
                # u0    u1    u20     u21
                nothing, n2(u0, s0, u1), s1, n2(u20, s20, u21)
            else
                n3(u0, s0, u1, s1, u2_), nothing, -1, nothing
            end
        end
    else
        error("assert invalid node")
    end
end

function tttree_add(x, t)
    if is_empty(t)
        singleton(x)
    elseif is_singleton(t)
        y = t.key
        u, v = min(x, y), max(x, y)
        tree(n2(leaf(u), v, leaf(v)))
    else
        t_, t0, s0, t1 = tttree_add_(x, t.t)
        if t_ === nothing
            tree(n2(t0, s0, t1))
        else
            tree(t_)
        end
    end
end

function tttree_lookup_(x, t)
    if is_leaf(t)
        x == t.keys[1]
    else
        n = length(t.children)
        for i in 1:n-1
            if x < t.keys[i]
                return tttree_lookup_(x, t.children[i])
            end
        end
        tttree_lookup_(x, t.children[n])
    end
end

function tttree_lookup(x, t)
    if is_empty(t)
        false
    elseif is_singleton(t)
        x == t.key
    else
        tttree_lookup_(x, t.t)
    end
end

# return (nil, nil) if t becomes empty after removing x
# return (nil, c0) if t becomes a single-child node whose sole child is c0
# return (t', nil) if t remains a valid node having 2 or 3 children after removing x
function tttree_remove_(x, t)
    if is_leaf(t)
        if x == t.keys[1]
            nothing, nothing # empty
        else
            t, nothing # unchanged
        end
    elseif length(t.children) == 2
        #    s0
        # u0    u1
        s0 = t.keys[1]
        u0, u1 = t.children[1], t.children[2]
        if x < s0
            u0_, u00 = tttree_remove_(x, u0)
            if u0_ === nothing && u00 === nothing
                # t becomes single-child node
                nothing, u1
            elseif u0_ === nothing
                #      s0
                #  u0_     u1
                #   |
                #  u00
                if length(u1.children) == 2
                    #      s0
                    #  u0_    u1
                    #   |     / \
                    #  u00  u10 u11
                    s10 = u1.keys[1]
                    u10, u11 = u1.children[1], u1.children[2]
                    nothing, n3(u00, s0, u10, s10, u11)
                elseif length(u1.children) == 3
                    #      s0
                    #  u0_    u1
                    #   |     /|\
                    #  u00  u10u11u12
                    s10, s11 = u1.keys[1], u1.keys[2]
                    u10, u11, u12 = u1.children[1], u1.children[2], u1.children[3]
                    n2(n2(u00, s0, u10), s10, n2(u11, s11, u12)), nothing
                else
                    error("assert invalid node")
                end
            else
                n2(u0_, s0, u1), nothing
            end
        else
            u1_, u10 = tttree_remove_(x, u1)
            if u1_ === nothing && u10 === nothing
                nothing, u0
            elseif u1_ === nothing
                #    s0
                # u0    u1_
                #        |
                #       u10
                if length(u0.children) == 2
                    #    s0
                    # u0    u1_
                    # /\     |
                    #u00u01  u10
                    s00 = u0.keys[1]
                    u00, u01 = u0.children[1], u0.children[2]
                    nothing, n3(u00, s00, u01, s0, u10)
                elseif length(u0.children) == 3
                    #      s0
                    #   u0     u1_
                    #  /|\     |
                    #u00u01u02 u10
                    s00, s01 = u0.keys[1], u0.keys[2]
                    u00, u01, u02 = u0.children[1], u0.children[2], u0.children[3]
                    n2(n2(u00, s00, u01), s01, n2(u02, s0, u10)), nothing
                else
                    error("assert invalid node")
                end
            else
                n2(u0, s0, u1_), nothing
            end
        end
    elseif length(t.children) == 3
        #    s0    s1
        # u0    u1    u2
        s0, s1 = t.keys[1], t.keys[2]
        u0, u1, u2 = t.children[1], t.children[2], t.children[3]
        if x < s0
            u0_, u00 = tttree_remove_(x, u0)
            if u0_ === nothing && u00 === nothing
                n2(u1, s1, u2), nothing
            elseif u0_ === nothing
                #    s0    s1
                # u0    u1    u2
                #  |
                # u00
                if length(u1.children) == 2
                    #    s0     s1
                    # u0     u1     u2
                    #  |     / \
                    # u00   u10 u11
                    s10 = u1.keys[1]
                    u10, u11 = u1.children[1], u1.children[2]
                    n2(n3(u00, s0, u10, s10, u11), s1, u2), nothing
                elseif length(u1.children) == 3
                    #    s0     s1
                    # u0     u1     u2
                    #  |     /|\
                    # u00  u10u11u12
                    s10, s11 = u1.keys[1], u1.keys[2]
                    u10, u11, u12 = u1.children[1], u1.children[2], u1.children[3]
                    n3(n2(u00, s0, u10), s10, n2(u11, s11, u12), s1, u2), nothing
                else
                    error("assert invalid node")
                end
            else
                n3(u0_, s0, u1, s1, u2), nothing
            end
        elseif x < s1
            u1_, u10 = tttree_remove_(x, u1)
            if u1_ === nothing && u10 === nothing
                n2(u0, s0, u2), nothing
            elseif u1_ === nothing
                #     s0    s1
                # u0    u1    u2
                #       |
                #      u10
                if length(u0.children) == 2
                    #     s0    s1
                    # u0    u1    u2
                    # /\     |
                    #u00u01  u10
                    s00 = u0.keys[1]
                    u00, u01 = u0.children[1], u0.children[2]
                    n2(n3(u00, s00, u01, s0, u10), s1, u2), nothing
                elseif length(u0.children) == 3
                    #      s0     s1
                    #   u0     u1    u2
                    #  /|\     |
                    #u00u01u02 u10
                    s00, s01 = u0.keys[1], u0.keys[2]
                    u00, u01, u02 = u0.children[1], u0.children[2], u0.children[3]
                    n3(n2(u00, s00, u01), s01, n2(u02, s0, u10), s1, u2), nothing
                else
                    error("assert invalid node")
                end
            else
                n3(u0, s0, u1_, s1, u2), nothing
            end
        else
            u2_, u20 = tttree_remove_(x, u2)
            if u2_ === nothing && u20 === nothing
                n2(u0, s0, u1), nothing
            elseif u2_ === nothing
                #     s0    s1
                # u0    u1    u2
                #             |
                #            u20
                if length(u1.children) == 2
                    #     s0    s1
                    # u0    u1    u2
                    #       /\     |
                    #     u10u11  u20
                    s10 = u1.keys[1]
                    u10, u11 = u1.children[1], u1.children[2]
                    n2(u0, s0, n3(u10, s10, u11, s1, u20)), nothing
                elseif length(u1.children) == 3
                    #      s0     s1
                    #   u0     u1     u2
                    #         /|\     |
                    #      u10u11u12  u20
                    s10, s11 = u1.keys[1], u1.keys[2]
                    u10, u11, u12 = u1.children[1], u1.children[2], u1.children[3]
                    n3(u0, s0, n2(u10, s10, u11), s11, n2(u12, s1, u20)), nothing
                else
                    error("assert invalid node")
                end
            else
                n3(u0, s0, u1, s1, u2_), nothing
            end
        end
    else
        error("assert invalid node")
    end
end

function tttree_remove(x, t)
    if is_empty(t)
        nothing
    elseif is_singleton(t)
        if x == t.key
            nothing
        else
            t
        end
    else
        t_, c0 = tttree_remove_(x, t.t)
        if t_ === nothing && c0 === nothing
            nothing
        elseif t_ === nothing
            if c0.children === nothing
                singleton(c0.keys[1])
            else
                tree(c0)
            end
        else
            tree(t_)
        end
    end
end

# end hidden
# end my answer

# add all values in list xs to tree t in order
function add_seq(xs, t)
    for x in xs
        t = tttree_add(x, t)
    end
    t
end

function lookup_seq(xs, t)
    for x in xs
        if !tttree_lookup(x, t)
            return false
        end
    end
    true
end

function remove_seq(xs, t)
    for x in xs
        t = tttree_remove(x, t)
    end
    t
end

# 0 ... n - 1
function range(n)
    collect(0 : n-1)
end

# random sequence
function random_seq(n, x)
    s = []
    for i in 1:n
        x = (0x5DEECE66D * x + 0xB) & 0xFFFFFFFFFFFF
        push!(s, Int(x >> 17))
    end
    s
end

# randomly shuffle xs
function random_shuffle(seed, xs)
    ys = random_seq(length(xs), seed)
    zs = collect(zip(ys, xs))
    sorted_zs = sort(zs, by=first)
    map(last, sorted_zs)
end

function print_vec(header, xs, n)
    print(header, "[")
    for (i, x) in enumerate(xs)
        if i > n
            print(" ...")
            break
        end
        if i > 1
            print(", ")
        end
        print(x)
    end
    println("]")
end

function check_seq(xs0, xs1)
    print_vec("insert in this order: ", xs0, 7)
    print_vec("remove in this order: ", xs1, 7)
    t = add_seq(xs0, nothing)
    tttree_check(t)
    if lookup_seq(xs1, t)
        e = remove_seq(xs1, t)
        e === nothing
    else
        false
    end
end

# randomly shuffle 0 .. n-1;
#   add them to empty tree;
#   remove all elements from the tree;
#   check they are sorted

function check_random(insert_seed, remove_seed, n)
    rng = range(n)
    xs0 = random_shuffle(insert_seed, rng)
    xs1 = random_shuffle(remove_seed, rng)
    check_seq(xs0, xs1)
end

function main()
    insert_seed = 1234
    remove_seed = 123456
    @assert check_random(insert_seed, remove_seed, 2)
    @assert check_random(insert_seed, remove_seed, 3)
    @assert check_random(insert_seed + 0, remove_seed + 0, 4)
    @assert check_random(insert_seed + 1, remove_seed + 1, 4)
    @assert check_random(insert_seed + 2, remove_seed + 2, 4)
    @assert check_random(insert_seed + 3, remove_seed + 3, 4)
    @assert check_random(insert_seed + 0, remove_seed + 0, 5)
    @assert check_random(insert_seed + 1, remove_seed + 1, 5)
    @assert check_random(insert_seed + 2, remove_seed + 2, 5)
    @assert check_random(insert_seed + 3, remove_seed + 3, 5)
    @assert check_random(insert_seed, remove_seed, 10)
    @assert check_random(insert_seed, remove_seed, 12)
    @assert check_random(insert_seed, remove_seed, 1000)
    @assert check_random(insert_seed, remove_seed, 10000)
    @assert check_random(insert_seed, remove_seed, 100000)
    println("OK")
end

main()
