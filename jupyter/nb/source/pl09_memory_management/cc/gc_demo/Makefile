cs:=$(wildcard *.c)
exes:=$(patsubst %.c,%,$(cs))

all : $(exes)
$(exes) : % : %.c
	gcc -Wall -Wextra -O3 $< -o $@ -lgc

clean :
	rm -f $(exes)
