set -eu
julia jl/readxml2/readxml2.jl /home/share/ps/build_system/readxml/data/expr_1.xml | diff - <(echo 1)
julia jl/readxml2/readxml2.jl /home/share/ps/build_system/readxml/data/expr_2.xml | diff - <(echo 2)
julia jl/readxml2/readxml2.jl /home/share/ps/build_system/readxml/data/expr_3.xml | diff - <(echo 3)
echo "OK"
