install:
	cd ~/ && wget -O go1.20.2.linux-amd64.tar.gz https://go.dev/dl/go1.20.2.linux-amd64.tar.gz
	cd ~/ && tar xf go1.20.2.linux-amd64.tar.gz
	cd ~/ && ~/go/bin/go install github.com/gopherdata/gophernotes@latest
	mkdir -p ~/.local/share/jupyter/kernels
	chmod 'u+w' ~/.local/share/jupyter/kernels
	chmod 'u+w' ~/.local/share/jupyter/kernels/gophernotes ; rm -rf ~/.local/share/jupyter/kernels/gophernotes
	cp -r ~/go/pkg/mod/github.com/gopherdata/gophernotes@v0.7.5/kernel ~/.local/share/jupyter/kernels/gophernotes
	chmod 644 ~/.local/share/jupyter/kernels/gophernotes/kernel.json
	sed 's:"gophernotes":"~/go/bin/gophernotes":g' ~/.local/share/jupyter/kernels/gophernotes/kernel.json.in > ~/.local/share/jupyter/kernels/gophernotes/kernel.json

uninstall:
	chmod -R 'u+w' ~/go ; rm -rf ~/go
	chmod -R 'u+w' ~/.local/share/jupyter/kernels/gophernotes ; rm -rf ~/.local/share/jupyter/kernels/gophernotes
	rm -f ~/go1.20.2.linux-amd64.tar.gz
