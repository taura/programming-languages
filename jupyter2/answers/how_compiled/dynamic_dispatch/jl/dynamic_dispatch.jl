abstract type Shape end

function call_area(s :: Shape) :: Float64
    area(s)
end

import InteractiveUtils
InteractiveUtils.code_native(call_area)
