set -eu
data=/home/share/ps/build_system/readxml/data/expr_3.xml
ml/cat/_build/default/bin/main.exe ${data} | diff ${data} -
echo "OK"
