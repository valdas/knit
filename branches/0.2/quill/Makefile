#---------------------------------------------------------------------------
This    = quill#
Version = 0.1#

about: 
	@echo "A test engine for QUILL function $(This), v$(Version)"
	@echo "copyright (c) GPL 3.0 2010 Tim Menzies, (tim AT menzies DOT us)"

include $(Knit)/lib/make/awk.mk # must be after defining "This" and "about"
#---------------------------------------------------------------------------

egWget:; @$(MAKE) -s This=wget build One="demoWget()" one #: wget demo
egRss :; @$(MAKE) -s This=rss  build One="demoRss()"  one #: rss demo
