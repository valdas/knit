#---------------------------------------------------------------------------
This    = helloworld#
Version = 0.1#

about: 
	@echo "$(This) v$(Version): a very small demo KNIT program"
	@echo "copyright (c) GPL 3.0 2010 Tim Menzies, (tim AT menzies DOT us)"

include $(Knit)/lib/make/awk.mk # must be after defining "This" and "about"
#---------------------------------------------------------------------------

eg0 : $(LibAwks) 

eg1 : 
	@$I; $(Run)

eg2 : 
	@$I; $(Spy); $(Dump)

eg3 : ; @$I; $(Run) -a
eg4 : ; @$I; $(Run) -h
eg5 : ; @$I; $(Run) -c

eg6 : 
	@$I; $(Run) -i $(Expect)/qualifiers.eg

eg7 : 
	@$I; cat $(Expect)/qualifiers.eg | $(Run) -i 


#eg4 : eg0; @$(Lib)/$(This) -To earl -Say "bye bye"
