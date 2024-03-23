install:
	cd ~/ && wget -O julia-1.8.5-linux-x86_64.tar.gz https://julialang-s3.julialang.org/bin/linux/x64/1.8/julia-1.8.5-linux-x86_64.tar.gz
	cd ~/ && tar xf julia-1.8.5-linux-x86_64.tar.gz
	mkdir -p ~/.local/share/jupyter/kernels
	chmod -R 'u+w' ~/.local/share/jupyter/kernels
	~/julia-1.8.5/bin/julia -e 'import Pkg; Pkg.add("IJulia"); using IJulia'

uninstall:
	rm -rf ~/.julia
	rm -rf ~/julia-1.8.5
	rm -f ~/julia-1.8.5-linux-x86_64.tar.gz

