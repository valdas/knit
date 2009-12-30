#MAKEFLAGS= -s

include $(Knit)/lib/make/dirs.mk
include $(Knit)/lib/make/test.mk

Egs  = $(shell grep '^eg' Makefile | sed 's/:.*//')
I    = printf "\n----| $@ |--------------\n\n"

help: about #: help
	@printf "\nUsage  : make [OPTIONS]*\nOptions:\n"
	@grep -h '^[a-zA-Z].*#:' $(Knit)/lib/make/*.mk Makefile  \
        | gawk -F: '{print "\t" $$1 "\t" $$3}' | sort

all : $(Egs) #: run all examples

installDir : 
	@$(foreach d, $(Dirs),\
		 if [ ! -d $d ]; then echo mkdir -p $d; mkdir -p $d; fi; )

install: installDir    # ensure everything is installed. warning: may be slow.
