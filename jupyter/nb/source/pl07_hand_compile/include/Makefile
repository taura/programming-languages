cs := $(wildcard *.c)
asms := $(patsubst %.c,asm/%.s,$(cs))

check_cs := $(wildcard check_*.c)
check_exes := $(patsubst %.c,exe/%,$(check_cs))

all : $(asms) $(check_exes)
#all : $(dels)

$(asms) : asm/%.s : %.c asm/dir
	gcc -o $@ -S -O3 -Wall -Wextra $<

$(check_exes) : exe/check_% : check_%.c exe/dir
	gcc -o $@ $< asm/$*.s -O3 -Wall -Wextra -lm

asm/dir exe/dir :
	mkdir -p $@

clean :
	rm -rf asm exe
