### if label == "Define data structure representing a rectangle and an ellipse"
struct Rect
    x :: Int
    y :: Int
    width :: Int
    height :: Int
end

struct Ellipse
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
shapes = [Rect(0, 0, 100, 100), Ellipse(0, 0, 100, 50)]
### endif
### if label == "Scan an array of shapes"
function sum_area(shapes)
    sa = 0.0
    for s in shapes
        sa += area(s)
    end
    sa
end

sum_area(shapes)
### endif
