set -eu
ml/readxml/_build/default/bin/main.exe /home/share/ps/build_system/readxml/data/expr_1.xml | diff - <(echo 1)
ml/readxml/_build/default/bin/main.exe /home/share/ps/build_system/readxml/data/expr_2.xml | diff - <(echo 2)
ml/readxml/_build/default/bin/main.exe /home/share/ps/build_system/readxml/data/expr_3.xml | diff - <(echo 3)
echo "OK"
