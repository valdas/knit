#---------------------------------------------------------------------------
This    = quill#
Version = 0.1#

about: 
	@echo "A test engine for QUILL function $(This), v$(Version)"
	@echo "copyright (c) GPL 3.0 2010 Tim Menzies, (tim AT menzies DOT us)"

include $(Knit)/lib/make/awk.mk # must be after defining "This" and "about"
#---------------------------------------------------------------------------

eg1 : #: Demo for wget
	$(MAKE) This=wget build One="demoWget()" one		

eg2 : #: Demo for rss. Usage- knit This=rss eg2
	@$a myRssDemo()  $z
