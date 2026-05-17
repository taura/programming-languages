set -eu
data=/home/share/ps/build_system/readxml/data/expr_3.xml
go/cat/cat ${data} | diff ${data} -
echo "OK"
