cs:=$(wildcard *.cc)
exes:=$(patsubst %.cc,%,$(cs))

all : $(exes)
$(exes) : % : %.cc
	g++ -Wall -Wextra -O3 $< -o $@

clean :
	rm -f $(exes)
