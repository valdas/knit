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

Download=$(Tags)/$(This)/$(Version)

tag : build #: install the current version into tags
	if [ ! -d "$(Download)" ]; then \
		mkdir -p $(Download) ;   \
		svn add $(This)      ;    \
	fi
	cd $(Download)
	cp  $(LatestBuild) $(This)
	svn add --quiet $(This)
	cd ../..
	svn commit -m "added : new version of $(This) $(Version)" 


installDir : 
	@$(foreach d, $(Dirs),\
		 if [ ! -d $d ]; then echo mkdir -p $d; mkdir -p $d; fi; )

install: installDir    # ensure everything is installed. warning: may be slow.

