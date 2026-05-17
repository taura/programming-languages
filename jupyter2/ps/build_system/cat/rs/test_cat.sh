set -eu
data=/home/share/ps/build_system/readxml/data/expr_3.xml
rs/cat/target/debug/cat ${data} | diff ${data} -
echo "OK"
