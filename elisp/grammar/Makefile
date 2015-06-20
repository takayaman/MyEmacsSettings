#
# File: grammar/Makefile
#
# $Id$
#

INCDIRS = -I. -I/usr/include/link-grammar
LIBDIRS = -L/usr/lib

objects := grammar.o

all: $(objects)
	g++ -g $(LIBDIRS) -o grammar $(objects) -llink-grammar

grammar.o: grammar.cc
	g++ -g $(INCDIRS) -c grammar.cc
