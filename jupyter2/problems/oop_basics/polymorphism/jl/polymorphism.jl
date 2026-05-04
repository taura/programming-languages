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
    @assert very_close(area(e0), 251.327412)
    @assert very_close(area(r0), 80.)
    @assert very_close(area(e1), 56.548668)
    @assert very_close(area(r1), 18.)
    @assert smaller(e0, e1) == 1
    @assert smaller(e0, r0) == 1
    println("OK")
end

main()
