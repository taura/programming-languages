function call_tanh(x :: Float64) :: Float64
    tanh(x + 1.0) + x
end

import InteractiveUtils
InteractiveUtils.code_native(call_tanh)
