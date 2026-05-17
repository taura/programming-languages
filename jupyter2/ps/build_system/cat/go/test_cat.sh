exe=go/cat/cat
data=/home/share/ps/build_system/cat/data/expr.xml
${exe} ${data} | diff ${data} -
