This    = penny# name
Version = 0.1#   number
about:       #: describe this software
	@echo "$(This) v$(Version): a 100 line(ish) content management system"
	@echo "copyright (c) GPL 3.0 2009 Tim Menzies, (tim AT menzies DOT us)"

#################################################
Code ?= penny.awk                                # where is your code?
Knit ?= /home/stuff/menzies.us/wave/knit/0.2/lib# where is knit?
include $(Knit)/make/awk.mk
##################################################

eg1 : $(Lib)/one.awk       #: check that the code does not crash
	@$(Run)  > /dev/null

eg2 :        #: look for escaped locals
	@$(Spy)  > /dev/null
	@egrep -v  "^[A-Z]*: " $(Vars)

eg3 :        #: how to chance the main function
	@$a print "look ma, ['$$USER'] is not using a main" $z

eg4 : $(Html)/penny.html
	cp $< $(HOME)/menzies.us/tmp

eg5 :        #: how to load the fillers
	@$a loadFillers("dat/filler.txt",out); \
            o(out,"fillers","cat") $z

eg6 : 
	gawk -f $(Knit)/awk/markup.awk doc/markup.wak
