go := $(wildcard *.go)
jl := $(wildcard *.jl)
ml := $(wildcard *.ml)
rs := $(wildcard *.rs)

go_exe := $(patsubst %.go,%.go.exe,$(go))
jl_exe := $(patsubst %.jl,%.jl.exe,$(jl))
ml_exe := $(patsubst %.ml,%.ml.exe,$(ml))
rs_exe := $(patsubst %.rs,%.rs.exe,$(rs))

all: $(go_exe) $(jl_exe) $(ml_exe) $(rs_exe)
go: $(go_exe)
jl: $(jl_exe)
ml: $(ml_exe)
rs: $(rs_exe)

$(go_exe) : %.go.exe : %.go
	go build -o $@ $<
	./$@

$(jl_exe) : %.jl.exe : %.jl
	julia $<

$(ml_exe) : %.ml.exe : %.ml
	ocamlc -o $@ $<
	./$@

$(rs_exe) : %.rs.exe : %.rs
	rustc -o $@ $<
	./$@

clean :
	rm -f *.exe *.cmi *.cmo
