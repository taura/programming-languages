
install:
	opam init --yes
	eval $$(opam env) && opam install --yes jupyter jupyter-archimedes menhir
	~/.opam/default/bin/ocaml-jupyter-opam-genspec
	jupyter kernelspec install --user --name ocaml-jupyter ~/.opam/default/share/jupyter

uninstall:
	rm -rf ~/.opam
	chmod 'u+w' ~/.local/share/jupyter/kernels ; rm -rf ~/.local/share/jupyter/kernels/ocaml-jupyter
