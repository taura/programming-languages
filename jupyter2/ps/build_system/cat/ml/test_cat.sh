exe=ml/cat/_build/default/bin/main.exe
data=/home/share/ps/build_system/cat/data/expr.xml
${exe} ${data} | diff ${data} -
