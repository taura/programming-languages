### if label == "Define data structure representing a rectangle and an ellipse"
abstract type Shape end
struct Rect <: Shape
    x :: Int
    y :: Int
    width :: Int
    height :: Int
end

struct Ellipse <: Shape
    x :: Int
    y :: Int
    rx :: Int
    ry :: Int
end
### endif
### if label == "Define a method that computes the area of rect/ellipse"
function area(r :: Rect)
    r.width * r.height
end

function area(e :: Ellipse)
    e.rx * e.ry * pi
end
### endif
### if label == "Create an array/a list/a vector/a slice"
shapes = [Rect(10, 20, 100, 100), Ellipse(30, 40, 100, 50)]
### endif
### if label == "Scan an array of shapes"
function sum_area(shapes :: Vector{Shape})
    sa = 0.0
    for s in shapes
        sa += area(s)
    end
    sa
end

println(sum_area(shapes))

function x_of(s :: Shape)
    s.x
end

function foo(a :: Vector{Rect})
    a[1] = Rect(0, 0, 200, 200)
end

function main()
    x = 0
    for s in shapes
        x += x_of(s)
    end
    println(x)
end
main()
### endif
