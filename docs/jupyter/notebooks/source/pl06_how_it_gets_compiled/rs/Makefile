rss := $(wildcard *.rs)
asms := $(patsubst %.rs,%.s,$(rss))

all : $(asms)

$(asms) : %.s : %.rs
	rustc -O --emit asm --crate-type lib $<

clean :
	rm -f $(asms)

.DELETE_ON_ERROR:
