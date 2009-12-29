### config
This    = helloworld#
Version = 0.1#
include $(Knit)/lib/make/awk.mk # must be after defining "This"

about: 
	@echo "$(This) v$(Version): a very small demo KNIT program"
	@echo "copyright (c) GPL 3.0 2010 Tim Menzies, (tim AT menzies DOT us)"

eg0 : $(LibAwks) 

eg1 : eg0
	@$(Run)

eg2 : eg0
	@$(Spy); $(Dump)

eg3 : eg0; @$(Run) -a
eg4 : eg0; @$(Run) -h


#eg4 : eg0; @$(Lib)/$(This) -To earl -Say "bye bye"
