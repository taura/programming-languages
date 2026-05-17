exe=jl/cat/cat.jl
data=/home/share/ps/build_system/cat/data/expr.xml
julia ${exe} ${data} | diff ${data} -
