jls := $(wildcard *.jl)
asms := $(patsubst %.jl,%.s,$(jls))

all : $(asms)

$(asms) : %.s : %.jl
	julia $< > $@

clean :
	rm -f $(asms)

.DELETE_ON_ERROR:

