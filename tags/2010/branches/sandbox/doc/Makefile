This    = doc#
Version = 0.1#

about: 
	@echo "This is the KNIT documentation project: $(This), v$(Version)"
	@echo "copyright (c) GPL 3.0 2010 Tim Menzies, (tim AT menzies DOT us)"

include $(Knit)/lib/make/awk.mk # must be after defining "This" and "about"
#---------------------------------------------------------------------------

Waks = $(subst .wak,,$(subst quill.wak,,$(shell ls *.wak)))

builds 	: 
	$(foreach i,$(Waks), \
			$(MAKE) -s This=$i buildHtmls; \
			svn -q add ../site/$i.html;\
			)
