#!/bin/bash 

set -eu

echo topic=${topic}
echo problem=${problem}
echo user=${user}
echo lang=${lang}
echo skel_dir=${skel_dir}
echo submission_dir=${submission_dir}
echo out_dir=${out_dir}

if diff --recursive ${skel_dir}/minc ${submission_dir}/minc; then
    echo "no work" 1>&2
    exit 1
fi
    
# copy the whole problem directory
rsync -a ${submission_dir}/../../minc ${out_dir}/

cd ${out_dir}
pwd
ls -lR minc
cd minc

clean_build() {
    case ${lang} in
	go)
	    export PATH=${PATH}:~/.local/go/bin:~/go/bin
	    go clean
	    go build
	    ;;
	jl)
	    export PATH=${PATH}:~/.juliaup/bin
	    ;;
	ml)
	    eval $(opam env)
	    dune clean
	    dune build
	    ;;
	rs)
	    . ~/.cargo/env
	    cargo clean
	    cargo build
	    ;;
    esac
}

(cd ${lang}/minc && clean_build)
(cd test && rm -rf asm gcc minc out)

run_test() {
    case ${lang} in
	go)
	    export PATH=${PATH}:~/.local/go/bin:~/go/bin
	    ;;
	jl)
	    export PATH=${PATH}:~/.juliaup/bin
	    ;;
	ml)
	    eval $(opam env)
	    ;;
	rs)
	    . ~/.cargo/env
	    ;;
    esac
    make
}

(cd test && run_test)

