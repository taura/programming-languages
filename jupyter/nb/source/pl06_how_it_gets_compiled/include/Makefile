cs := $(wildcard c/*.c)
gos := $(wildcard go/*.go)
jls := $(wildcard jl/*.jl)
mls := $(wildcard ml/*.ml)
rss := $(wildcard rs/*.rs)

c_asms := $(patsubst %.c,%.s,$(cs))
go_asms := $(patsubst %.go,%.s,$(gos))
jl_asms := $(patsubst %.jl,%.s,$(jls))
ml_asms := $(patsubst %.ml,%.s,$(mls))
rs_asms := $(patsubst %.rs,%.s,$(rss))

all_asms :=
all_asms += $(c_asms)
all_asms += $(go_asms)
all_asms += $(jl_asms)
all_asms += $(ml_asms)
all_asms += $(rs_asms)

all : $(all_asms)

$(c_asms) : %.s : %.c
	gcc -O3 -S $< -o $@

$(go_asms) : %.s : %.go
#	go tool compile -I $(shell go env GOROOT)/pkg/$(shell go env GOOS)_$(shell go env GOARCH) -o $*.o $<
	go tool compile -l -o $*.o $< 
	go tool objdump -gnu $*.o > $@

$(jl_asms) : %.s : %.jl
#	julia --load $< --eval 'using InteractiveUtils; code_native(add123)' > $@
	julia $< > $@

$(ml_asms) : %.s : %.ml
	ocamlopt -S $<

$(rs_asms) : %.s : %.rs
	rustc -O --emit asm --crate-type lib $< -o $@

clean :
	rm -f c/*.s go/*.s go/*.o jl/*.s ml/*.s ml/*.o ml/*.cmi ml/*.cmx rs/*.s

.DELETE_ON_ERROR:
