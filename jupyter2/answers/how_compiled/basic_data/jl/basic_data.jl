function add_nums(x :: Int64, y :: Int64) :: Int64
    x + y + 123
end

import InteractiveUtils
InteractiveUtils.code_native(add_nums)
