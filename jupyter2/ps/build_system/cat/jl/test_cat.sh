set -eu
data=/home/share/ps/build_system/readxml/data/expr_3.xml
julia jl/cat/cat.jl ${data} | diff ${data} -
echo "OK"
