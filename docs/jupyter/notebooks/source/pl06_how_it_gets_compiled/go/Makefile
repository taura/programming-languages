gos := $(wildcard *.go)
asms := $(patsubst %.go,%.s,$(gos))

all : $(asms)

$(asms) : %.s : %.go
	gccgo -g0 -O3 -S $<

clean :
	rm -f $(asms)

.DELETE_ON_ERROR:

