### begin my answer

### begin hidden
struct FreeEllipse
    a::Float64
    b::Float64
end

function mk_free_ellipse(a, b)
    FreeEllipse(a, b)
end

function area(e::FreeEllipse)
    π * e.a * e.b
end

struct FreeRect
    w::Float64
    h::Float64
end

function mk_free_rect(w, h)
    FreeRect(w, h)
end

function area(r::FreeRect)
    r.w * r.h
end

function smaller(s0, s1)
    area(s0) <= area(s1) ? 0 : 1
end

### end hidden
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
