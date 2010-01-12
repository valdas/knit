#---------------------------------------------------------------------------
This    = penny#
Version = 0.1#

about: 
	@echo "$(This) v$(Version): a very small content management system"
	@echo "copyright (c) GPL 3.0 2010 Tim Menzies, (tim AT menzies DOT us)"

include $(Knit)/lib/make/awk.mk # must be after defining "This" and "about"
#---------------------------------------------------------------------------


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
	@gawk -f $(Knit)/lib/awk/markup.awk doc/markup.wak

eg7 : 
	@gawk -f $(Knit)/lib/awk/markup.awk doc/markup1.wak

eg8 : 
	@gawk -f $(Knit)/lib/awk/uses.awk

eg9 :
	@$a print 2222; loadTags("etc/tests/tags.txt") $z
