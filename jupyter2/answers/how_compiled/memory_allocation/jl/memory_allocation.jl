function mk_point(x :: Float64, y :: Float64) :: Point
    Point(x + 1.0, y + 2.0)
end

import InteractiveUtils
InteractiveUtils.code_native(mk_point)
