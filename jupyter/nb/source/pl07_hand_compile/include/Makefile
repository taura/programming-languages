cs := $(wildcard *.c)
dels := $(patsubst %.c,del_%.s,$(cs))
asms := $(patsubst %.c,asm/%.s,$(cs))

all : $(asms)
#all : $(dels)

$(dels) : del_%.s : %.c
	git rm $*.s

$(asms) : asm/%.s : %.c asm/dir
	gcc -o $@ -S -O3 $<

asm/dir :
	mkdir -p $@
clean :
	rm -rf asm
