This    = doc#
Version = 0.1#

about: 
	@echo "This is the KNIT documentation project: $(This), v$(Version)"
	@echo "copyright (c) GPL 3.0 2010 Tim Menzies, (tim AT menzies DOT us)"

include $(Knit)/lib/make/awk.mk # must be after defining "This" and "about"
#---------------------------------------------------------------------------

Waks = $(subst .wak,,$(subst quill.wak,,$(shell ls *.wak)))

builds 	: wakToHtml checkTags htmlCommits

wakToHtml :
	$(foreach i,$(Waks), $(MAKE) -s This=$i buildHtmls; )

htmlCommits :
	svn -q add *.wak ../site/$i.html
	cd .. ; svn commit -m "updating waks, htmls"

checkTags :
	@$(foreach i,$(Waks), \
		if   grep $i.html ../site/etc/tags.txt > /dev/null;   \
		then true; \
		else echo "Warning: missing in ../site/etc/tags.txt : $i.html" ; \
		fi; )
