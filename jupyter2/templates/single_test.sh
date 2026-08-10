#!/bin/bash 

set -eu

echo topic=${topic}
echo problem=${problem}
echo user=${user}
echo lang=${lang}
echo skel_dir=${skel_dir}
echo submission_dir=${submission_dir}
echo out_dir=${out_dir}

# compare with skeleton
if diff ${submission_dir}/${problem}.${lang} ${skel_dir}/${problem}.${lang}; then
    echo "no work" 1>&2
    exit 1
fi

# copy source file(s)
cp ${submission_dir}/${problem}.${lang} ${out_dir}/
cd ${out_dir}

case ${lang} in
    go)
       export PATH=${PATH}:~/.local/go/bin:~/go/bin
       go build -o ${problem}.exe ${problem}.${lang} 
       ./${problem}.exe > out.txt
       ;;
    jl)
	export PATH=${PATH}:~/.juliaup/bin
	julia ${problem}.jl > out.txt
       ;;
    ml)
	eval $(opam env)
	ocamlc ${problem}.ml -o ${problem}.exe
	./${problem}.exe > out.txt
	;;
    rs)
	. ~/.cargo/env
	rustc ${problem}.rs -o ${problem}.exe
	./${problem}.exe > out.txt
	;;
    *)
	echo "invalid lang ${lang}" 1>& 2
	exit 1
	;;
esac

cat out.txt
grep OK out.txt
