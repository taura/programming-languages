### begin my answer

### begin hidden
abstract type AbstractShape end
abstract type AbstractEllipse <: AbstractShape end
abstract type AbstractRect <: AbstractShape end

struct FreeEllipse <: AbstractEllipse
    a::Float64
    b::Float64
end

function mk_free_ellipse(a, b)
    FreeEllipse(a, b)
end

function area(e::AbstractEllipse)
    π * e.a * e.b
end

struct Ellipse <: AbstractEllipse
    a::Float64
    b::Float64
    x0::Float64
    y0::Float64
end

function mk_ellipse(a, b, x0, y0)
    Ellipse(a, b, x0, y0)
end

function contains(e::Ellipse, x, y)
    dx = x - e.x0
    dy = y - e.y0
    (dx^2) / (e.a^2) + (dy^2) / (e.b^2) <= 1.0
end

struct FreeRect <: AbstractRect
    w::Float64
    h::Float64
end

function mk_free_rect(w, h)
    FreeRect(w, h)
end

function area(r::AbstractRect)
    r.w * r.h
end

struct Rect <: AbstractRect
    w::Float64
    h::Float64
    x0::Float64
    y0::Float64
end

function mk_rect(w, h, x0, y0)
    Rect(w, h, x0, y0)
end

function contains(r::Rect, x, y)
    x >= r.x0 && x <= r.x0 + r.w && y >= r.y0 && y <= r.y0 + r.h
end

function smaller(s0::AbstractShape, s1::AbstractShape)
    area(s0) <= area(s1) ? 0 : 1
end

function mk_free_shapes()
    [
        mk_free_ellipse(16., 5.),
        mk_free_rect(16., 5.),
        mk_free_ellipse(6., 3.),
        mk_free_rect(6., 3.)
  ]
end

function mk_shapes() 
    [
        mk_ellipse(16., 5., -15., -4.),
        mk_rect(16., 5., -15., -4.),
        mk_ellipse( 6., 3.,  -3., -2.),
        mk_rect( 6., 3.,  -3., -2.)
    ]
end

function mk_mixed_shapes() 
    [
        mk_free_ellipse(16., 5.),
        mk_free_rect(16., 5.),
        mk_free_ellipse(6., 3.),
        mk_free_rect(6., 3.),
        mk_ellipse(16., 5., -15., -4.),
        mk_rect(16., 5., -15., -4.),
        mk_ellipse( 6., 3.,  -3., -2.),
        mk_rect( 6., 3.,  -3., -2.)
    ]
end

function sum_area(seq)
    s = 0.
    for sh in seq
        s += area(sh)
    end
    s
end

function count_contains(seq, x, y) 
    c = 0
    for sh in seq
        if contains(sh, x, y)
            c += 1
        end
    end
    c
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
