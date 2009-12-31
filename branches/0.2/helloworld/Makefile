#---------------------------------------------------------------------------
This    = helloworld#
Version = 0.1#

about: 
	@echo "$(This) v$(Version): a very small demo KNIT program"
	@echo "copyright (c) GPL 3.0 2010 Tim Menzies, (tim AT menzies DOT us)"

include $(Knit)/lib/make/awk.mk # must be after defining "This" and "about"
#---------------------------------------------------------------------------

eg1 : 
	@$I; $(Run)

eg2 : 
	$I; $(Spy); $(Dump) 

# the following shows the code running as seperate files, included using "-f"
eg3 : ; @$I; $(Run) -a
eg4 : ; @$I; $(Run) -h
eg5 : ; @$I; $(Run) -c
eg6 : ; @$I; $(Run) -i $(Tests)/qualifiers.eg
eg7 : ; @$I; cat $(Tests)/qualifiers.eg | $(Run) -i 

# the following shows the code running as one file, in $(LatestBuild)
eg8  : ; @$I; $(LatestBuild) -a
eg9  : ; @$I; $(LatestBuild) -i $(Tests)/qualifiers.eg
eg10 : ; @$I; cat $(Tests)/qualifiers.eg | $(LatestBuild) -i 

eg11 : 
	$(foreach h,$(HtmlHtmls), echo $h;)
