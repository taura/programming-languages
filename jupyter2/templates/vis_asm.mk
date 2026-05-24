gos:=$(wildcard ../ps/how_compiled/*/go/*.go)
jls:=$(wildcard ../ps/how_compiled/*/jl/*.jl)
mls:=$(wildcard ../ps/how_compiled/*/ml/*.ml)
rss:=$(wildcard ../ps/how_compiled/*/rs/*.rs)

go_asms:=$(patsubst %.go,%.s,$(gos))
jl_asms:=$(patsubst %.jl,%.s,$(jls))
ml_asms:=$(patsubst %.ml,%.s,$(mls))
rs_asms:=$(patsubst %.rs,%.s,$(rss))

svgs:=$(patsubst %.s,%.svg,$(go_asms) $(jl_asms) $(ml_asms) $(rs_asms))

all: $(svgs)

$(svgs) : %.svg : %.s
	vis-asm $<

$(go_asms) : %.s : %.go
	go build -o go/$*.o $<
	go tool objdump -gnu go/$*.o > $@

$(jl_asms) : %.s : %.jl
	julia $< > $@

$(ml_asms) : %.s : %.ml
	ocamlopt -S $<

$(rs_asms) : %.s : %.rs
	rustc -O --emit=asm --crate-type lib $< -o $@

clean:
	rm -f $(go_asms) $(jl_asms) $(ml_asms) $(rs_asms) ??/*.o ??/*.cmi ??/*.cmx

.DELETE_ON_ERROR:



