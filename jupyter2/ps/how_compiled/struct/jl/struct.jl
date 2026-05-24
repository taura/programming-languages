struct Point
    x :: Float64
    y :: Float64
end

function get_point_y(p :: Point) :: Float64
    p.y
end

import InteractiveUtils
InteractiveUtils.code_native(get_point_y)
