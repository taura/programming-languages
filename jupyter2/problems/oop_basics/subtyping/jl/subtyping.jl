### begin my answer

### end my answer

function very_close(x, y)
    abs(x - y) < 1e-6
end

function main()
    e0 = mk_free_ellipse(16., 5.)
    r0 = mk_free_rect(16., 5.)
    e1 = mk_free_ellipse( 6., 3.)
    r1 = mk_free_rect( 6., 3.)
    d0 = mk_ellipse(16., 5., -15., -4.)
    q0 = mk_rect(16., 5., -15., -4.)
    d1 = mk_ellipse( 6., 3.,  -3., -2.)
    q1 = mk_rect( 6., 3.,  -3., -2.)
    @assert very_close(area(e0), 251.327412)
    @assert very_close(area(r0), 80.)
    @assert very_close(area(e1), 56.548668)
    @assert very_close(area(r1), 18.)
    @assert very_close(area(d0), 251.327412)
    @assert very_close(area(q0), 80.)
    @assert very_close(area(d1), 56.548668)
    @assert very_close(area(q1), 18.)
    @assert smaller(e0, e1) == 1
    @assert smaller(e0, r0) == 1
    @assert smaller(d1, q0) == 0
    @assert smaller(e0, d0) == 0
    s0 = mk_free_shapes()
    s1 = mk_shapes()
    s2 = mk_mixed_shapes()
    # un-comment only lines below that run successfully
    # @assert count_contains(s0, 0.0, 0.0) == 3
    @assert count_contains(s1, 0.0, 0.0) == 3
    # @assert count_contains(s2, 0.0, 0.0) == 6
    @assert very_close(sum_area(s0), 405.876080)
    @assert very_close(sum_area(s1), 405.876080)
    @assert very_close(sum_area(s2), 811.752160)
    println("OK")
end

main()
