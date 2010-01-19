#---------------------------------------------------------------------------
This    = penny#
Version = 0.1#

about: 
	@echo "$(This) v$(Version): a very small content management system"
	@echo "copyright (c) GPL 3.0 2010 Tim Menzies, (tim AT menzies DOT us)"

include $(Knit)/lib/make/awk.mk # must be after defining "This" and "about"
#---------------------------------------------------------------------------


eg0 : build

eg1 : $(Lib)/one.awk       #: check that the code does not crash
	@$(Run)  > /dev/null

eg2 :        #: look for escaped locals
	@$(Spy)  > /dev/null
	@egrep -v  "^[A-Z]*: " $(Vars)

eg3 :        #: how to chance the main function
	@$a print "look ma, ['$$USER'] is not using a main" $z

eg4 : $(Html)/penny.html
	cp $< $(HOME)/menzies.us/tmp

eg5 :  eg0      #: how to load the fillers
	@$a loadFillers("dat/filler.txt",out); \
            o(out,"fillers","cat") $z

eg6 :  eg0
	@gawk -f $(Knit)/lib/awk/markup.awk doc/markup.wak

eg7 : eg0
	@gawk -f $(Knit)/lib/awk/markup.awk doc/markup1.wak

eg8 : eg0
	@gawk -f $(Knit)/lib/awk/uses.awk

eg9 : eg0
	@$A loadTags("etc/tests/tags.txt",files,titles,tags,sgat); print "----";\
         os(files,"files",titles,"titles",tags,"tags",sgat,"sgat")  $(Z)
	$(Dump);


eg10 : eg0
	@$A testQueryString("etc/tests/tags.txt","nosql") $Z


eg11 : eg0
	@$A testQueryString("etc/tests/tags.txt","Admin") $Z

eg12 : eg0
	@$A testQueryString("etc/tests/tags.txt","advocacy&Admin&Jan&Misc&title=love") $Z

eg13 : eg0
	QUERY_STRING="nosql" gawk 'BEGIN {print ENVIRON["QUERY_STRING"]}'

