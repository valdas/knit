#---------------------------------------------------------------------------
This    = helloworld#
Version = 0.1#

about: 
	@echo "$(This) v$(Version): a very small demo KNIT program"
	@echo "copyright (c) GPL 3.0 2010 Tim Menzies, (tim AT menzies DOT us)"

include $(Knit)/lib/make/awk.mk # must be after defining "This" and "about"
#---------------------------------------------------------------------------

eg0 : build

eg1 : eg0
	@$I; $(Run)

eg2 : eg0
	$I; $(Spy); $(Dump) 

eg3 : build 
		echo "$(Run)"
	@$I; $(Run) -a

eg4 : build ; @$I; $(Run) -h
eg5 : build ; @$I; $(Run) -c
eg6 : build ; @$I; $(Run) -i $(Tests)/qualifiers.eg
eg7 : build ; @$I; cat $(Tests)/qualifiers.eg | $(Run) -i 

# the following shows the code running as one file, in $(LatestBuild)
eg8  : build ; @$I; $(LatestBuild) -a
eg9  : build ; @$I; $(LatestBuild) -i $(Tests)/qualifiers.eg
eg10 : build ; @$I; cat $(Tests)/qualifiers.eg | $(LatestBuild) -i 

eg11 : build
	@$a help() $z

eg12 : build
	@$A help() $Z; $(Dump)
