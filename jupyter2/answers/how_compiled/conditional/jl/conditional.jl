function gcd1(a :: Int64, b :: Int64) :: Int64
    if b == 0
        a
    else
        a % b
    end
end

import InteractiveUtils
InteractiveUtils.code_native(gcd1)
