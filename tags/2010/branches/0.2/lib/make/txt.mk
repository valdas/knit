# must be first
include $(Knit)/lib/make/tricks.mk

Uses    := $(shell $(This).txt)

Htmls   := $(subst .txt,.html,$(Uses))
HtmlHtmls :=  $(subst $(Html)/ ,,$(Html)/$(subst .html ,.html $(Html)/,$(Htmls)) $(Html)/$(This).html)#

OldBuild = $(Old)/$(This).$(Version)
LatestBuild = $(Lib)/$(This)

build : buildHtmls #: Build htmls

buildHtmls: $(HtmlHtmls)

$(Html)/%.html : %.txt
	cat $< | \
	$(Gawk0) -f $(Knit)/lib/awk/rinclude.awk |  \
 	$(Gawk0) -f $(Knit)/lib/awk/markup.awk   > $@

demo : 
	@$a $(shell $(Demo)) $z


