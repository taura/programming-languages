mls := $(wildcard *.ml)
asms := $(patsubst %.ml,%.s,$(mls))
cmis := $(patsubst %.ml,%.cmi,$(mls))
cmxs := $(patsubst %.ml,%.cmx,$(mls))
os := $(patsubst %.ml,%.o,$(mls))

all : $(asms)

$(asms) : %.s : %.ml
	ocamlopt -c -S $<

clean :
	rm -f $(asms) $(cmis) $(cmxs) $(os)

.DELETE_ON_ERROR:
